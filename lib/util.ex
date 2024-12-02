defmodule Aoc.Util do
  def parse_lines(input, split \\ "\n") do
    input
    |> String.split(split)
    |> Enum.flat_map(fn line ->
      case String.trim(line) do
        "" -> []
        str -> [str]
      end
    end)
  end

  def d(data, opts \\ []) do
    default = [charlists: :as_lists]
    dbg(data, Keyword.merge(default, opts))
  end
end
