defmodule Mix.Tasks.Execute do
  use Mix.Task

  @impl
  def run(args) do
    [year, day] = args

    "Elixir.Aoc.Y#{year}.D#{day}"
    |> String.to_existing_atom()
    |> apply(:run, [])
  end
end
