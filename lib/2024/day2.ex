defmodule Aoc.Y2024.D2 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    helper(input)
    |> Enum.reduce(0, fn line, acc ->
      if is_safe?(parse_row(line)) do
        acc + 1
      else
        acc
      end
    end)
  end

  defp is_safe?(list), do: is_safe?(list, 0)
  defp is_safe?([], _), do: true
  defp is_safe?([_ | [] ], _), do: true

  defp is_safe?([a | [b | rest] ], last) do
    {safe, diff} = safe_diff?(a, b, last)
    if safe do
      is_safe?([b | rest], diff)
    end
  end

  defp safe_diff?(x, y, last) do
    diff = y - x

    if abs(diff) < 1 || abs(diff) > 3 || (diff > 0 && last < 0) || (diff < 0 && last > 0) do
      {false, diff}
    else
      {true, diff}
    end
  end

  def part2(input) do
    helper(input)
    |> Enum.reduce(0, fn line, acc ->
      if is_safe2?(parse_row(line)) do
        acc + 1
      else
        acc
      end
    end)
  end

  defp is_safe2?(list), do: is_safe2?(list, 0, 0, false)
  defp is_safe2?([], _, _, _), do: true
  defp is_safe2?([_ | [] ], _, _, _), do: true

  defp is_safe2?([a | [b | rest] ], prev_diff, prev_diff2, removed) do
    {safe, diff} = safe_diff2?(a, b, prev_diff)
    if safe do
      is_safe2?([b | rest], diff, prev_diff, removed)
    else
      unless removed do
        unless is_safe2?([a | rest], prev_diff, prev_diff2, true) do
          prev_number = a - prev_diff
          # If prev_diff2 is 0 then we're at the second item of the list, and can potentially change direction
          if prev_diff2 == 0 do
            first_number = prev_number - prev_diff2
            is_safe2?([first_number, prev_number, b] ++ rest, 0, 0, true)
          else
            is_safe2?([prev_number, b] ++ rest, prev_diff, prev_diff2, true)
          end
        else
          true
        end
      end
      # false
    end
  end

  # defp is_safe2?([a | [b | rest] ], last, removed, original_list) do
  #   {safe, diff} = safe_diff2?(a, b, last)
  #   if safe do
  #     is_safe2?([b | rest], diff, removed)
  #   else
  #     unless removed do
  #       unless is_safe2?([a | rest], last, true, original_list) do
  #         prev_number = a - last
  #         # If we're at the second item of the list we can potentially change direction
  #         if start_over?(rest, original_list) do
  #           is_safe2?([prev_number, b] ++ rest, 0, 0, true)
  #         else
  #           is_safe2?([prev_number, b] ++ rest, last, true, original_list)
  #         end
  #       else
  #         true
  #       end
  #       # if length(rest) == 2, do: true
  #     end
  #     false
  #   end
  # end

  # defp start_over(rest, original) do
  #   length(rest) == length(original) - 3
  # end

  defp safe_diff2?(x, y, last) do
    diff = y - x

    if abs(diff) < 1 || abs(diff) > 3 || (diff > 0 && last < 0) || (diff < 0 && last > 0) do
      {false, diff}
    else
      {true, diff}
    end
  end

  @spec helper(binary()) :: list()
  def helper(input) do
    input |> parse_lines()
  end

  defp parse_row(line) do
    Enum.map(String.split(line), fn str -> parse_int(str) end)
  end
end
