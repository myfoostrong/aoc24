defmodule Aoc.Main do
  def main(args) do
    case args do
      [] -> IO.puts("No year and day given")
      [year, day] -> Aoc.Runner.run(year, day)
      [year, day, part] -> Aoc.Runner.run(year, day, part)
    end
  end
end
