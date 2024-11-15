defmodule Mix.Tasks.Gen.Aoc do
  use Mix.Task

  @shortdoc "Generates AoC module file for a given year and day."

  def run(args) do
    Mix.Task.run("app.start")

    IO.puts("Beginning generation")

    [year, day] = args

    Mix.Generator.create_directory("lib/#{year}")
    Mix.Generator.copy_template("priv/templates/Aoc.ex.eex", "lib/#{year}/day#{day}.ex", day: day, year: year)
    Mix.Generator.copy_template("priv/templates/aoc_test.ex.eex", "test/#{year}/day#{day}_test.exs", day: day, year: year)
    Mix.Generator.create_file("priv/inputs/#{year}/day#{day}.txt", Aoc.Client.get_input(year, day))

    IO.puts("Done!")
  end
end
