defmodule Day3 do
  def part1() do
    Day1.read_txt("day3.txt")
    |> String.split("\n")
    |> Enum.filter(fn x -> String.length(x) != 0 end)
    |> Enum.map(fn x -> String.graphemes(x) end)
    |> Enum.map(fn inner ->
      Enum.map(inner, fn x -> parse_int(x) end)
    end)
    |> Enum.map(fn inner ->
      # joltage(inner) |> Enum.max()
      combinex(inner)
    end)
    |> Enum.sum()
    |> IO.inspect()
  end

  def joltage(nums) do
    for {x, xi} <- Enum.with_index(nums),
        {y, yi} <- Enum.with_index(nums),
        yi > xi,
        do: Integer.undigits([x, y])
  end

  def combinex(nums) do
    all_combine =
      for {x, xi} <- Enum.with_index(nums),
          {y, yi} <- Enum.with_index(nums),
          yi > xi,
          do: [{x, xi}, {y, yi}]

    res_valid =
      Enum.filter(all_combine, fn [{_, xi}, {_, yi}] ->
        xi < yi
      end)

    res_valid
    |> Enum.map(fn [{a, _}, {b, _}] ->
      Integer.undigits([a, b])
    end)
    |> Enum.max()
  end

  def parse_int(val) do
    {res, _} = Integer.parse(val)
    res
  end
end
