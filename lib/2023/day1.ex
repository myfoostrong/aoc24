defmodule Aoc.Y2023.D1 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    lines = helper(input)
    answer = lines
    |> Enum.reduce(0, fn line, acc ->
        chars = String.graphemes(line)
        first = elem(Integer.parse(Enum.find(chars, fn x -> is_int?(x) end)), 0)
        last = elem(Integer.parse(Enum.find(Enum.reverse(chars), fn x -> is_int?(x) end)), 0)
        acc + 10 * first + last
      end)
    IO.puts(answer)
    :ok
  end

  def part2(input) do
    :ok
  end

  def helper(input) do
    input |> parse_lines()
  end

  defp is_int?(input) do
    case Integer.parse(input) do
      {_, ""} -> true
      _ -> false
    end
  end
end
