defmodule AocTest.Y2024.D6 do
  use ExUnit.Case, async: true

  alias Aoc.Y2024.D6, as: Solver

  @example """
  ....#.....
  .........#
  ..........
  ..#.......
  .......#..
  ..........
  .#..^.....
  ........#.
  #.........
  ......#...
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 41
    end

    test "part 2" do
      assert Solver.part2(@example) == :ok
    end
  end
end
