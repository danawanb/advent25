defmodule Day5 do
  def part1() do
    [ranges, ids] =
      Day1.read_txt("day5.txt")
      |> String.split("\n\n")

    hay =
      ranges
      |> String.split("\n")
      |> Enum.map(fn x -> String.split(x, "-") end)
      |> Enum.map(fn [a, b] ->
        {String.to_integer(a), String.to_integer(b)}
      end)

    ids
    |> String.split("\n")
    |> Enum.filter(fn x -> String.length(x) != 0 end)
    |> Enum.map(fn x -> String.to_integer(x) end)
    |> Enum.filter(fn x -> is_in_range(hay, x) end)
    |> Enum.count()
    |> IO.inspect()
  end

  defp is_in_range(haystack, needle) do
    Enum.any?(haystack, fn {a, b} ->
      a <= needle and needle <= b
    end)
  end
end
