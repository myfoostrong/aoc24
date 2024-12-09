defmodule Aoc.Y2024.D9 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    disk = helper(input)
    |> Enum.with_index()
    # |> Enum.reverse()
    # |> then(fn [{[x],i}|rest] -> [{[x,0],i} | rest] end)
    # |> Enum.reverse()
    # |> fast_compact()

    # Too Slow
    |> calc_blocks()
    |> compact_fs()
    # IO.puts(disk))
  end
  # 6484194307037 too high

  # defp fast_compact(list), do: fast_compact(list, Enum.reverse(list))
  # defp fast_compact(disk, [{[x],i}| rest]), do: fast_compact(disk, [{[x,0],i}| rest], 0, 0)
  # defp fast_compact([{_,i} | _], [{_, j} | _], acc, _) when i > j, do: acc
  # defp fast_compact([],_,_)

  # 2333133121414131402
    # Part 1: [
    #   {[2, 3], 0},
    #   {[3, 3], 1},
    #   {[1, 3], 2},
    #   {[3, 1], 3},
    #   {[2, 1], 4},
    #   {[4, 1], 5},
    #   {[4, 1], 6},
    #   {[3, 1], 7},
    #   {[4, 0], 8},
    #   {[2, 0], 9}
    # ]
    # 00...111...2...333.44.5555.6666.777.888899
    # Length of list
    # 0099811188827773336446555566
    # 333 84 7*12 + 91 7*13 + 98 7*14 = 606
    # (15+16+17)*3  = 750
    # 6*18 = 858
    # 19+20)*4 = 1014 21*6 = 1140
    # (22+23+24+25)*5 = 470 = 1610
  # defp fast_compact([head | rest_disk], [tail | rest_rev], acc, i) do
  #   {[h_blocks, h_free], h_id} = head
  #   [{[t_blocks, t_free], t_id} | rest] = tail
  #   acc = acc +
  #     (i..(i+h_blocks-1)
  #   |> Enum.map(fn x -> x * h_id end)
  #   |> Enum.sum())
  #   i = i + h_blocks

  #   cond do
  #     h_free > t_blocks ->
  #       diff =
  #       acc = acc + (i..(i+t_blocks-1)
  #       |> Enum.map(fn x -> x * t_id end)
  #       |> Enum.sum())
  #       fast_compact([{[0,h_free - t_blocks], 0} | rest_disk], rest_rev, acc, i + t_blocks)

  #     h_free == t_blocks ->
  #       acc = acc +
  #         (i..(i+t_blocks-1)
  #       |> Enum.map(fn x -> x * t_id end)
  #       |> Enum.sum())
  #       fast_compact(rest_disk, rest_rev, acc, i + t_blocks)

  #     h_free < t_blocks ->
  #       diff = t_blocks - h_free
  #       acc = acc +
  #         (i..(i+h_free-1)
  #       |> Enum.map(fn x -> x * t_id end)
  #       |> Enum.sum())
  #       fast_compact(rest_disk, [{[t_blocks- h_free, t_free], t_id} | rest_rev], acc, i+h_free)
  #   end
  # end

  defp fast_compact(list), do: fast_compact(list, 0, 0)
  defp fast_compact([], acc, _), do: acc

  defp fast_compact([head | []], acc, i) do
    {[h_blocks, h_free], h_id} = head
    acc = acc +
      (i..(i+h_blocks-1)
    |> Enum.map(fn x -> x * h_id end)
    |> Enum.sum())
  end


  defp fast_compact([head | rest], acc, i) do
    {[h_blocks, h_free], h_id} = head
    [{[t_blocks, t_free], t_id} | rest] = Enum.reverse(rest)
    acc = acc +
      (i..(i+h_blocks-1)
    |> Enum.map(fn x -> x * h_id end)
    |> Enum.sum())
    i = i + h_blocks

    cond do
      h_free > t_blocks ->
        diff =
        acc = acc + (i..(i+t_blocks-1)
        |> Enum.map(fn x -> x * t_id end)
        |> Enum.sum())

        fast_compact([{[0,h_free - t_blocks], 0} | Enum.reverse(rest)], acc, i + t_blocks)

      h_free == t_blocks ->
        acc = acc +
          (i..(i+t_blocks-1)
        |> Enum.map(fn x -> x * t_id end)
        |> Enum.sum())

        fast_compact(Enum.reverse(rest), acc, i + t_blocks)

      h_free < t_blocks ->
        diff = t_blocks - h_free
        acc = acc +
          (i..(i+h_free-1)
        |> Enum.map(fn x -> x * t_id end)
        |> Enum.sum())

        fast_compact(Enum.reverse([{[t_blocks- h_free, t_free], t_id} | rest]), acc, i+h_free)
    end
  end

  defp calc_blocks(blocks), do: calc_blocks(blocks, [])
  defp calc_blocks([], acc), do: acc
  defp calc_blocks([{[x], i}], acc), do: calc_blocks([{[x,0], i}], acc)
  defp calc_blocks([{block, id} | rest], acc) do
    [file,free] = block
    acc = acc ++ List.duplicate(id,file) ++ List.duplicate(".",free)
    calc_blocks(rest, acc)
  end

  defp compact_fs(fs_list) do
    rev_fs = Enum.reverse(fs_list)
    compact_fs(fs_list, rev_fs, [], 0, length(fs_list))
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {x,y} -> x*y end)
    |> Enum.sum()
  end

  defp compact_fs([], _, acc), do: acc
  defp compact_fs(_, _, acc, fl, rl) when fl > rl, do: acc

  defp compact_fs(rest_fs, ["." | rest_rev], acc, fl, rl) do
    compact_fs(rest_fs, rest_rev, acc, fl, rl)
  end

  defp compact_fs(["." | rest_fs], [x | rest_rev], acc, fl, rl) do
    compact_fs(rest_fs, rest_rev, [x | acc], fl+1, rl)
  end

  defp compact_fs([x | rest_fs], rest_rev, acc, fl, rl) do
    compact_fs(rest_fs, rest_rev, [x | acc], fl+1, rl-1)
  end

  def part2(input) do
    :ok
  end

  def helper(input) do
    input |> parse_lines()
    |> Enum.at(0)
    |> String.graphemes()
    |> Enum.map(&parse_int/1)
    |> Enum.chunk_every(2)
  end
end
