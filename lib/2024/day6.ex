defmodule Aoc.Y2024.D6 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    {layout, h_blocks, v_blocks, start} = helper(input)
    layout = map_path(start, h_blocks, v_blocks, layout)
    count_cells(layout)
  end

  defp map_path(start, h_blocks, v_blocks, layout),
    do: map_path(start, h_blocks, v_blocks, layout, :up)
  defp map_path({x,y}, _, _, layout, _) when x == 0 or y == 0 or x == 129 or y == 129, do: layout
  defp map_path(start, h_blocks, v_blocks, layout, direction) do
    {x, y} = start
    hb = Map.get(h_blocks, y, [])
    vb = Map.get(v_blocks, x, [])
    next_coord = move_direction(start, hb, vb, direction)
    layout = walk_layout(layout, {x, y}, next_coord, direction)
    map_path(next_coord, h_blocks, v_blocks, layout, next_direction(direction))
  end

  defp next_direction(direction) do
    case direction do
      :up -> :right
      :right -> :down
      :down -> :left
      :left -> :up
    end
  end

  defp move_direction({x, y}, hb, vb, direction) do
    {case direction do
      :right -> Enum.find(hb, 130, fn block -> block > x end) - 1
      :left -> (Enum.reverse(hb) |> Enum.find(-1, fn block -> block < x end)) + 1
      _ -> x
    end,
    case direction do
      :up -> (Enum.reverse(vb) |> Enum.find(-1, fn block -> block < y end)) + 1
      :down -> (Enum.find(vb, 130, fn block -> block > y end)) - 1
      _ -> y
    end}
  end

  defp walk_layout(layout, {x, y}, {x2, y2}, direction) do
    case direction do
      :up ->
        Enum.with_index(layout)
        |> Enum.map(fn {row, i} -> if i <= y and i >= y2 do
            List.replace_at(row, x, "X")
          else
            row
          end
        end)
      :down ->
        Enum.with_index(layout)
        |> Enum.map(fn {row, i} -> if i >= y and i <= y2 do
            List.replace_at(row, x, "X")
          else
            row
          end
        end)
      :right ->
        row = Enum.reduce(x..x2, Enum.at(layout, y), &(List.replace_at(&2, &1, "X")))
        List.replace_at(layout, y, row)
      :left ->
        row = Enum.reduce(x2..x, Enum.at(layout, y), &(List.replace_at(&2, &1, "X")))
        List.replace_at(layout, y, row)
    end
  end


  defp count_cells(layout) do
    layout
    |> Enum.reduce(0, fn row, acc ->
      Enum.reduce(row, acc, fn c, acc2 ->
        if c == "X" do
          acc2 + 1
        else
          acc2
        end
      end)
    end)
  end

  @spec part2(any()) :: :ok
  def part2(input) do
    :ok
  end

  def helper(input) do
    layout = input |> parse_lines()
    |> Enum.map(&String.graphemes/1)

    horizontal_blocks = Enum.with_index(layout)
    |> Enum.map(fn {row, y} ->
      {y, Enum.with_index(row)
      |> Enum.reduce([], &parse_cell/2)
      |> Enum.reverse()}
    end)
    |> Enum.into(%{})

    vertical_blocks = Enum.reduce(horizontal_blocks,
    %{}, fn {y, row}, acc ->
        Enum.reduce(row, acc, fn x, acc2 ->
          blocks = Map.get(acc2, x, [])
          Map.put(acc2, x, [y | blocks])
        end)
      end)
    |> Enum.reduce(%{}, fn {x, list}, acc -> Map.put(acc, x, Enum.reverse(list)) end)

    {row_length, _} = :binary.match(input, "\n")
    row_length = row_length + 1
    {start_idx, _} = :binary.match(input, "^")
    y = div(start_idx, row_length)
    x = start_idx - y * row_length
    start = {x, y}

    {layout, horizontal_blocks, vertical_blocks, start}
  end

  defp parse_cell({"#",x}, acc), do: [x | acc ]
  defp parse_cell(_, acc), do: acc
end
