defmodule Aoc.Y2024.D2 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    helper(input)
    |> Enum.reduce(0, fn line, acc ->
      if is_safe?(parse_row(line)) do
        acc + 1
      else
        acc
      end
    end)
  end

  defp is_safe?(list), do: is_safe?(list, 0)
  defp is_safe?([], _), do: true
  defp is_safe?([_ | [] ], _), do: true

  defp is_safe?([a | [b | rest] ], last) do
    {safe, diff} = safe_diff?(a, b, last)
    if safe do
      is_safe?([b | rest], diff)
    end
  end


  ### Part 2

  def part2(input) do
    helper(input)
    |> Enum.reduce(0, fn line, acc ->
      if is_safe2?(parse_row(line)) do
        acc + 1
      else
        acc
      end
    end)
  end

  defp is_safe2?(list), do: is_safe2?(list, 0, 0, false)
  defp is_safe2?([], _, _, _), do: true
  defp is_safe2?([_ | [] ], _, _, _), do: true

  defp is_safe2?([a | [b | rest] ], prev_diff, prev_diff2, modified) do
    {safe, diff} = safe_diff?(a, b, prev_diff)
    prev_number = a - prev_diff
    [ c | _ ] = rest
    cond do
      safe -> is_safe2?([b | rest], diff, prev_diff, modified)
      modified -> false
      length(rest) == 0 -> true
      is_safe2?([a , c], prev_diff, prev_diff2, true) -> is_safe2?([a , rest], prev_diff, prev_diff2, true)
      prev_diff == 0 -> is_safe2?([b | rest], 0, 0, true)
      prev_diff2 == 0 ->
        unless is_safe2?([a, b] ++ rest, 0, 0, true) do
          is_safe2?([prev_number, b] ++ rest, 0, 0, true)
        else
          true
        end
      true -> is_safe2?([prev_number, b] ++ rest, prev_diff, prev_diff2, true)
    end
  end

  @spec helper(binary()) :: list()
  def helper(input) do
    input |> parse_lines()
  end

  defp parse_row(line) do
     Enum.map(String.split(line), fn str -> parse_int(str) end)
  end

  defp safe_diff?(x, y, prev_diff) do
    diff = y - x
    safe = cond do
      abs(diff) < 1 -> false
      abs(diff) > 3 -> false
      diff > 0 && prev_diff < 0 -> false
      diff < 0 && prev_diff > 0 -> false
      true -> true
    end
    {safe, diff}
  end
end