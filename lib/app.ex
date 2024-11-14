defmodule Aoc.Application do
  use Application

  def start(_type, _args) do
    unless Mix.env() == :prod do
      Dotenv.load()
      Mix.Task.run("loadconfig")
    end
  end
end
