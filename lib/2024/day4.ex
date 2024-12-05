defmodule Aoc.Y2024.D4 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    {grid, coords} = helper(input)
    |> build_grid()
    search_xmas(grid, coords)
  end

  defp build_grid(input), do: build_grid(input, {}, [], 0)
  defp build_grid([], grid, x_coords, _), do: {grid, x_coords}

  defp build_grid([row_string | rest], grid, x_coords, i) do
    row = String.graphemes(row_string)
    new_grid = Tuple.append(grid, List.to_tuple(row))
    new_coords = find_x(row, i) ++ x_coords
    build_grid(rest, new_grid, new_coords, i+1)
  end

  defp find_x(row, j), do: find_x(row, {0, j}, [])
  defp find_x([], _, arr), do: arr
  defp find_x(["X" | rest], {i, j}, arr), do: find_x(rest,{i+1, j}, [{i,j} | arr])
  defp find_x([_ | rest], {i, j}, arr), do: find_x(rest, {i+1, j}, arr)


  defp search_xmas(grid, coords), do: search_xmas(grid, coords, 0)
  defp search_xmas(_, [], arr), do: arr

  defp search_xmas(grid, [coord | rest], arr) do
    search_xmas(grid, rest, arr + check_xmas(grid, coord))
  end

  defp check_xmas(grid, coord), do: check_xmas(grid, coord, get_cell(grid, coord))

  defp check_xmas(grid, {i, j}, "X") do
    Enum.reduce(
      [:up, :down, :left, :right, :up_left, :up_right, :down_left, :down_right],
      0,
      fn direction, acc ->
        xmas = check_xmas(grid, {i, j}, "M", direction)
        # if xmas == 1 do
        write_logfile("#{i},#{j} #{direction} #{xmas}")
        # end
        acc + xmas
      end
    )
  end
  defp check_xmas(_, _, _), do: 0

  defp check_xmas(_, _, "$", _), do: 1
  defp check_xmas(grid, {i, j}, c, direction) when c in ["M","A","S"] do
    {dx, dy} = get_delta(direction)
    next_coord = {i + dx, j + dy}
    unless get_cell(grid, next_coord) == c do
      0
    else
      check_xmas(grid, next_coord, get_next_char(c), direction)
    end
  end
  defp check_xmas(_, _, _, _), do: 0

  defp get_cell(grid, {i, j}) when i > tuple_size(grid) - 1 or j > tuple_size(grid) - 1, do: nil
  defp get_cell(_, {-1, _}), do: nil
  defp get_cell(_, {_, -1}), do: nil

  defp get_cell(grid, {i, j}) do
    elem(elem(grid, j),i)
  end

  defp get_next_char(c) do
    case c do
      "X" -> "M"
      "M" -> "A"
      "A" -> "S"
      "S" -> "$"
    end
  end

  defp get_delta(direction) do
    case direction do
      :up -> {0,-1}
      :down -> {0,1}
      :left -> {-1,0}
      :right -> {1,0}
      :up_left -> {-1,-1}
      :up_right -> {1,-1}
      :down_left -> {-1,1}
      :down_right -> {1,1}
    end
  end

  @spec part2(any()) :: :ok
  def part2(input) do
    {grid, coords} = helper(input)
    |> build_grid2()
    search_xmas2(grid, coords)
  end

  defp build_grid2(input), do: build_grid2(input, {}, [], 0)
  defp build_grid2([], grid, x_coords, _), do: {grid, x_coords}

  defp build_grid2([row_string | rest], grid, x_coords, i) do
    row = String.graphemes(row_string)
    new_grid = Tuple.append(grid, List.to_tuple(row))
    new_coords = find_a(row, i) ++ x_coords
    build_grid2(rest, new_grid, new_coords, i+1)
  end

  defp find_a(row, j), do: find_a(row, {0, j}, [])
  defp find_a([], _, arr), do: arr
  defp find_a(["A" | rest], {i, j}, arr), do: find_a(rest,{i+1, j}, [{i,j} | arr])
  defp find_a([_ | rest], {i, j}, arr), do: find_a(rest, {i+1, j}, arr)

  defp search_xmas2(grid, coords), do: search_xmas2(grid, coords, 0)
  defp search_xmas2(_, [], arr), do: arr

  defp search_xmas2(grid, [coord | rest], arr) do
    search_xmas2(grid, rest, arr + check_xmas2(grid, coord))
  end

  defp check_xmas2(grid, {i, j}) do
    Enum.map(
      [:up_left, :down_right, :down_left, :up_right],
      fn direction ->
        n = get_neighbor(grid, {i, j}, direction)
        # if xmas == 1 do
        write_logfile("#{i},#{j} #{direction} #{n}")
        # end
        n
      end
    )
    |> is_x()
  end

  defp is_x([ul, dl, ur, dr]) do
    if is_x([ul, dl]) and is_x([ur, dr]) do
      1
    else
      0
    end
  end
  defp is_x([u, d]), do: (u == "M" and d == "S") or (u == "S" and d == "M")
  defp is_x(_), do: 0

  defp get_neighbor(grid, {i, j}, direction) do
    {dx, dy} = get_delta(direction)
    next_coord = {i + dx, j + dy}
    get_cell(grid, next_coord)
  end

  def helper(input) do
    input |> parse_lines()
  end
end
