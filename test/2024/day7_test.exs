defmodule AocTest.Y2024.D7 do
  use ExUnit.Case, async: true

  alias Aoc.Y2024.D7, as: Solver

  @example """
  190: 10 19
  3267: 81 40 27
  83: 17 5
  156: 15 6
  7290: 6 8 6 15
  161011: 16 10 13
  192: 17 8 14
  21037: 9 7 18 13
  292: 11 6 16 20
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 3749
    end

    test "part 2" do
      assert Solver.part2(@example) == :ok
    end
  end
end
