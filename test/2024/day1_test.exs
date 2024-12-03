defmodule AocTest.Y2024.D1 do
  use ExUnit.Case, async: true

  alias Aoc.Y2024.D1, as: Solver

  @example """
  3   4
  4   3
  2   5
  1   3
  3   9
  3   3
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 11
    end

    test "part 2" do
      assert Solver.part2(@example) == 31
    end
  end
end
