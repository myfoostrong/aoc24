defmodule Aoc.Y2024.D5 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    %{rules: rules, updates: updates} = helper(input)
    |> Enum.reduce(%{rules: [], updates: []}, &parse_row/2)

    rulebook = build_rulebook(rules)
    Enum.reduce(updates, 0, fn update, acc ->
      if check_order(rulebook, update) do
        acc + Enum.at(update, div(length(update),2), 0)
      else
        acc
      end
    end)
  end

  defp check_order(rulebook, updates), do: check_order(rulebook, Enum.with_index(updates), [])
  defp check_order(_, [], _), do: true
  defp check_order(rulebook, [a | rest], seen) do
    {a, _} = a
    in_order = Map.get(Map.get(rulebook, a, %{up: []}), :up, [])
    |> Enum.all?(fn x -> x not in seen end)

    if in_order do
      check_order(rulebook, rest, [a | seen])
    else
      nil
    end
  end



  def part2(input) do
    %{rules: rules, updates: updates} = helper(input)
    |> Enum.reduce(%{rules: [], updates: []}, &parse_row/2)
    rulebook = build_rulebook(rules)
    Enum.reduce(updates, 0, fn update, acc ->
      unless check_order(rulebook, update) do
        ordered_update = sort_update(rulebook, update)
        mid = Enum.at(ordered_update, div(length(ordered_update),2), 0)
        mid + acc
      else
        acc
      end
    end)
  end

  defp sort_update(rulebook, update) do
    Enum.sort(update, fn x, y ->
      y_in_x_up = Map.get(Map.get(rulebook, x, %{up: []}), :up, [])
      |> Enum.any?(fn z -> z == y end)
      x_in_y_down = Map.get(Map.get(rulebook, y, %{down: []}), :down, [])
      |> Enum.any?(fn z -> z == x end)
      y_in_x_up or x_in_y_down
    end)
  end

  def helper(input) do
    input |> parse_lines()
  end

  defp parse_row("", acc), do: acc
  defp parse_row(<<head::binary-size(2), <<"|", tail::binary>> >>, acc) do
    %{acc | rules: [{parse_int(head), parse_int(tail)} | acc.rules]}
  end
  defp parse_row(row, acc) do
    %{acc | updates: [Enum.map(String.split(row,","), &parse_int/1) | acc.updates]}
  end

  defp build_rulebook(rules) do
    Enum.reduce(rules, %{}, fn rule, acc ->
      {lo, hi} = rule
      lo_map = Map.get(acc, lo, %{down: [], up: [] })
      hi_map = Map.get(acc, hi, %{down: [], up: []})
      acc = Map.put(acc, lo, %{lo_map | up: [hi | lo_map.up] })
      Map.put(acc, hi, %{hi_map | down: [ lo | hi_map.down]})
    end)
  end
end
