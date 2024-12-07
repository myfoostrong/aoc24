defmodule Aoc.Y2024.D7 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    runs = helper(input)
    clear_addition(runs)
    |> clear_multiplication()
    |> validate_runs()
  end
  # 882304363039 too high

  defp clear_addition(runs), do: clear_addition(runs, {0, []})
  defp clear_addition([], acc), do: acc

  defp clear_addition([run | rest], acc) do
    {acc, runs} = acc
    {test, params} = run
    if test == Enum.sum(params) do
      clear_addition(rest, {acc + test, runs})
    else
      clear_addition(rest, {acc, [run | runs]})
    end
  end

  defp clear_multiplication({acc, runs}), do: clear_multiplication(runs, {acc, []})
  defp clear_multiplication([], acc), do: acc

  defp clear_multiplication([run | rest], acc) do
    {acc, runs} = acc
    {test, params} = run
    if test == Enum.product(params) do
      clear_multiplication(rest, {acc + test, runs})
    else
      clear_multiplication(rest, {acc, [run | runs]})
    end
  end

  defp validate_runs({acc, runs}) do
    Enum.reduce(runs, acc, fn run, acc ->
      if validate_run(run) do
        {test, _} = run
        acc + test
      else
        acc
      end
    end)
  end
  # defp validate_runs([], acc), do: acc
  # defp validate_runs(rest, acc) do
  #   acc + validate_run(run)
  # end

  defp validate_run({test, params}), do: validate_run(Enum.reverse(params), test, test)
  defp validate_run([], 0, _), do: true
  defp validate_run([], _, _), do: false
  defp validate_run(_, remain, _) when remain < 0, do: false

  defp validate_run([p | rest], remain, test) do
    acc = validate_run(rest, remain - p, test)
    if rem(remain, p) == 0 do
      acc or validate_run(rest, div(remain, p), test)
    else
      acc
    end
  end

  def part2(input) do
    :ok
  end

  def helper(input) do
    input |> parse_lines()
    |> Enum.map(fn row ->
      [test | [params | []]] = String.split(row, ":")
      params = String.split(params)
      |> Enum.map(fn x -> parse_int(x) end)
      {parse_int(test), params}
    end)
  end
end
