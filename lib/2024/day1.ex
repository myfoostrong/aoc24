defmodule Aoc.Y2024.D1 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    x = helper(input)
    |> Enum.reduce([[], []], fn line, acc ->
      for {str, list} <- Enum.zip(String.split(line, "   "), acc) do
        insort(list, elem(Integer.parse(str), 0))
      end
    end)
    Enum.zip(x)
    |> Enum.reduce(0, fn {left, right}, acc ->
      abs(left - right) + acc
    end)
  end

  defp insort(list, input) do
    Enum.sort([input | list])
  end

  def part2(input) do
    :ok
  end

  def helper(input) do
    input |> parse_lines()
  end
end
