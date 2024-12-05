defmodule AocTest.Y2024.D4 do
  use ExUnit.Case, async: true

  alias Aoc.Y2024.D4, as: Solver

  @example """
  MMMSXXMASM
  MSAMXMSMSA
  AMXSXMAAMM
  MSAMASMSMX
  XMASAMXAMM
  XXAMMXXAMA
  SMSMSASXSS
  SAXAMASAAA
  MAMMMXMMMM
  MXMXAXMASX
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 18
    end

    test "part 2" do
      assert Solver.part2(@example) == 9
    end
  end
end
