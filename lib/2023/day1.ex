defmodule Aoc.Y2023.D1 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    helper(input)
    |> Enum.reduce(0, fn line, acc ->
        chars = String.graphemes(line)
        first = get_digit(chars)
        last = get_digit(Enum.reverse(chars))
        acc + 10 * first + last
      end)
  end

  defp get_digit(chars) do
    elem(Integer.parse(
      Enum.find(chars,
      fn x -> is_int?(x) end)), 0)
  end

  def part2(input) do
    helper(input)
    |> Enum.reduce(0, fn line, acc ->
      chars = String.graphemes(line)
      first = get_digit2(chars)
      last = get_digit2(Enum.reverse(chars))
      acc + 10 * first + last
    end)
  end

  defp get_digit2(chars) do
    elem(chars, 0)
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
