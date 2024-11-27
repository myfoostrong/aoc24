defmodule Aoc.Y2023.D1 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    lines = helper(input)
    lines
    |> Enum.find(fn x -> is_int?(x) end)
    |> IO.puts()
    :ok
  end

  def part2(input) do
    :ok
  end

  def helper(input) do
    input |> parse_lines()
  end

  defp is_int?(input) do
    case input do
      {_, ""} -> true
      _ -> false

    end
  end
end
