defmodule Aoc.Runner do
  def run(year, day, part \\ nil) do
    module = "Elixir.Aoc.Y#{year}.D#{day}" |> String.to_existing_atom()
    args = if part, do: [part], else: []
    apply(module, :run, args)
  end

  defmacro __using__(opts) do
    default = [inspect: false, input: true]
    opts = Keyword.merge(default, opts)

    quote do
      def run() do
        input = get_input()
        part1(input) |> IO.inspect(label: "Part 1")
        part2(input) |> IO.inspect(label: "Part 2")

        :ok
      end

      def run(1), do: get_input() |> part1()
      def run(2), do: get_input() |> part2()

      def parse_module_name(module_name) do
        module_name
        |> String.split(".")
        |> Enum.take(-2)
        |> Enum.map(fn <<_, num::binary>> -> num |> String.to_integer() end)
      end

      if unquote(opts[:input]) do
        def get_input() do
          module_name = to_string(__MODULE__)
          [year, day] = parse_module_name(module_name)
          input_path = "/priv/inputs/#{year}/day#{day}.txt"

          # Let it explode for file not found, better than nil
          File.read!(File.cwd!() <> input_path)
        end
      end
    end
  end
end
