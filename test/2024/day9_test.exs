defmodule AocTest.Y2024.D9 do
  use ExUnit.Case, async: true

  alias Aoc.Y2024.D9, as: Solver

  @example """
  2333133121414131402
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 1928
    end

    test "part 2" do
      assert Solver.part2(@example) == :ok
    end
  end
end
