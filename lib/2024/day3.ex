defmodule Aoc.Y2024.D3 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    for line <- helper(input), reduce: 0 do
      total -> total + for instr <- find_mul(line), reduce: 0 do
        acc -> acc + run_mul(instr)
      end
    end
  end

  def part2(input) do
    :ok
  end

  defp helper(input) do
    input |> parse_lines()
  end

  defp find_mul(input) do
    regex = ~r/mul\([0-9]{1,3},[0-9]{1,3}\)/
    x = Regex.scan(regex, input)
    x
  end

  defp run_mul(instr) do
    prefix = "mul("
    delim = ","
    suffix = ")"
    <<_::binary-size(4), args::binary>> = hd(instr)
    [left_str, rest] = String.split(args, ",")
    right_str = String.slice(rest, 0..-2//1)
    parse_int(left_str) * parse_int(right_str)
  end
end
