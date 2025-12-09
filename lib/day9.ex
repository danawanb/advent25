defmodule Day9 do
  def part1() do
    list =
      Day1.read_txt("day9.txt")
      |> String.split("\n")
      |> Enum.filter(fn x -> String.length(x) != 0 end)
      |> pairwise()
      |> Enum.map(fn {a, b} -> score(a, b) end)
      |> Enum.sort_by(fn {_, _, val} -> val end, :desc)
      |> hd()
      |> IO.inspect()
  end

  def pairwise(list) do
    for {elem, idx} <- Enum.with_index(list),
        next <- Enum.slice(list, idx + 1, length(list)),
        do: {elem, next}
  end

  def score(a, b) do
    [x1, y1] = String.split(a, ",")
    [x2, y2] = String.split(b, ",")

    xint1 = String.to_integer(x1)
    xint2 = String.to_integer(x2)
    yint1 = String.to_integer(y1)
    yint2 = String.to_integer(y2)

    {xint1, yint1, xint2, yint2}
    x = abs(xint1 - xint2) + 1
    y = abs(yint1 - yint2) + 1

    {a, b, x * y}
  end

  def split_con(a, b) do
    [x1, y1] = String.split(a, ",")
    [x2, y2] = String.split(b, ",")

    xint1 = String.to_integer(x1)
    xint2 = String.to_integer(x2)
    yint1 = String.to_integer(y1)
    yint2 = String.to_integer(y2)
    {xint1, yint1, xint2, yint2}
  end
end
