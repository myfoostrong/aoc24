defmodule Aoc.Y2024.D1 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    helper(input)
    |> Enum.reduce([[], []], fn line, acc ->
      for {coord, list} <- Enum.zip(parse_coords(line), acc) do
        Enum.sort([coord | list])
      end
    end)
    |> Enum.zip()
    |> Enum.reduce(0, fn {left, right}, acc ->
      abs(left - right) + acc
    end)
  end

  defp parse_coords(line) do
    Enum.map(String.split(line, "   "), fn str -> parse_int(str) end)
  end

  def part2(input) do
    {final_list, final_counter} = helper(input)
    |> Enum.reduce({[], %{}}, fn line, {list, counter} ->
      [left, right] = parse_coords(line)
      {
        [left | list],
        case Map.get(counter, right) do
          nil   -> Map.put(counter, right, 1)
          count -> Map.put(counter, right, count + 1)
        end
      }
    end)
    Enum.reduce(final_list, 0, fn coord, acc ->
      case Map.get(final_counter, coord) do
        nil   -> 0 + acc
        count -> count * coord + acc
      end
    end)
  end

  def helper(input) do
    input |> parse_lines()
  end
end
