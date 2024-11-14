defmodule Mix.Tasks.Download do
  use Mix.Task

  @impl Mix.Task
  def run(args) do
    [year, day] = args

    Mix.Task.run("app.start")

    filename = "priv/inputs/#{year}/day#{day}.txt"

    File.write(filename, Aoc.Client.get_input(year, day))

    IO.puts("Downloaded input for day #{day} of year #{year} to #{filename}")
  end
end
