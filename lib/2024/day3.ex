defmodule Aoc.Y2024.D3 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    for instr <- find_mul(Enum.join(helper(input), " ")), reduce: 0 do
      acc -> acc + run_mul(instr)
    end
  end

  defp find_mul(input) do
    regex = ~r/mul\([0-9]{1,3},[0-9]{1,3}\)/
    Regex.scan(regex, input)
  end

  def part2(input) do
    x = Enum.map(find_enabled_instrs(input), fn y -> find_mul(y) end)
    for instr <- x, reduce: 0 do
      acc -> acc + run_mul([instr])
    end
  end

  defp find_enabled_instrs(input) do
    String.split(input, "do()")
    |> Enum.map(fn s -> hd(String.split(s, "don't()")) end)
    |> List.flatten()
  end

  defp helper(input) do
    input |> parse_lines()
  end

  defp run_mul(instr) do
    <<_::binary-size(4), args::binary>> = hd(instr)
    [left_str, rest] = String.split(args, ",")
    right_str = String.slice(rest, 0..-2//1)
    parse_int(left_str) * parse_int(right_str)
  end
end
