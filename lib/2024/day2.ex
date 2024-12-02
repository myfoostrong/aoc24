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
  defp is_safe?([], last), do: true
  # defp is_safe?(<<a, <<>> >>, last), do: true


  defp is_safe?([a | [b | rest] ], last) do
    # <<b , rrest::binary >> = rest
    {safe, diff} = safe_diff?(a, b, last)
    if safe do
      is_safe?([b | rest], diff)
    end
  end
  defp is_safe?([a | [] ], last), do: true

  defp safe_diff?(x, y, last) do
    diff = y - x

    if abs(diff) < 1 || abs(diff) > 3 || (diff > 0 && last < 0) || (diff < 0 && last > 0) do
      {false, diff}
    else
      {true, diff}
    end
  end

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

  defp is_safe2?(list), do: is_safe2?(list, 0, false)
  defp is_safe2?([], last, _), do: true

  defp is_safe2?([a | [b | rest] ], last, removed) do
    {safe, diff} = safe_diff?(a, b, last)
    if safe do
      is_safe2?([b | rest], diff, removed)
    else
      unless removed do
        unless is_safe2?([a | rest], last, true) do
          first = a - last
          is_safe2?([first, b] ++ rest, last, true)
        else
          true
        end
        if length(rest) == 2, do: true
      end
    end
  end
  defp is_safe2?([a | [] ], last, _), do: true

  def helper(input) do
    input |> parse_lines()
  end

  defp parse_row(line) do
    Enum.map(String.split(line), fn str -> parse_int(str) end)
  end
end
