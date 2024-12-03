defmodule AocTest.Y2024.D3 do
  use ExUnit.Case, async: true

  alias Aoc.Y2024.D3, as: Solver

  @example """
  xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
  """

  @example2 """
  xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example1) == 161
    end

    test "part 2" do
      assert Solver.part2(@example2) == 48
    end
  end
end
