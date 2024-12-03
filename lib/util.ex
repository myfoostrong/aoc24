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

  @spec d(any(), keyword()) :: any()
  def d(data, opts \\ []) do
    default = [charlists: :as_lists]
    dbg(data, Keyword.merge(default, opts))
  end

  def parse_int(str) do
    {integer, remainder} = Integer.parse(str)
    integer
  end

  def write_logfile(str) do
    path = "./debug.log"
    {:ok, file} = File.open(path, [:append])
    IO.binwrite(file, str <> "\n")
    File.close(file)
  end

  def clear_logfile() do
    path = "./debug.log"
    {:ok, file} = File.open(path, [:write])
    File.close(file)
  end
end
