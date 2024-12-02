defmodule Aoc.Client do
  def get_input(year, day) do
    Req.get!("https://adventofcode.com/#{year}/day/#{day}/input",
      headers: [
        {"Cookie", "session=#{cookie()}"}
      ]
    ).body
  end

  defp cookie, do: Dotenv.get("AOC_SESSION")
end
