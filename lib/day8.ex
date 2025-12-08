defmodule Day8 do
  def part1() do
    list =
      Day1.read_txt("day8.txt")
      |> String.split("\n")
      |> Enum.filter(fn x -> String.length(x) != 0 end)
      |> pairwise()
      |> Enum.map(fn {a, b} -> euclidean(a, b) end)
      |> Enum.sort_by(fn {_, _, x} -> x end, :asc)

    list_ten = Enum.take(list, 1000)

    list_parent =
      Day1.read_txt("day8.txt")
      |> String.split("\n")
      |> Enum.filter(fn x -> String.length(x) != 0 end)
      |> Enum.map(&{&1, &1})
      |> Enum.into(%{})

    parent_map =
      redisjoint(list_ten, list_parent)

    parent_map
    |> Map.keys()
    |> Enum.reduce(%{}, fn node, acc ->
      {root, _} = find(parent_map, node)
      Map.update(acc, root, 1, &(&1 + 1))
    end)
    |> Map.values()
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.reduce(fn x, acc -> x * acc end)
    |> IO.inspect()
  end

  def pairwise(list) do
    for {elem, idx} <- Enum.with_index(list),
        next <- Enum.slice(list, idx + 1, length(list)),
        do: {elem, next}
  end

  def euclidean(a, b) do
    [x1, y1, z1] = String.split(a, ",")
    [x2, y2, z2] = String.split(b, ",")

    xx1 = String.to_integer(x1)
    yy1 = String.to_integer(y1)
    zz1 = String.to_integer(z1)

    xx2 = String.to_integer(x2)
    yy2 = String.to_integer(y2)
    zz2 = String.to_integer(z2)

    x = :math.pow(xx1 - xx2, 2)
    y = :math.pow(yy1 - yy2, 2)
    z = :math.pow(zz1 - zz2, 2)
    {a, b, :math.sqrt(x + y + z)}
  end

  def redisjoint([], parent), do: parent

  def redisjoint([{a, b, _} | t], parent) do
    parent = union(parent, a, b)
    redisjoint(t, parent)
  end

  def find(parent, x) do
    if parent[x] == x do
      {x, parent}
    else
      {root, parent} = find(parent, parent[x])
      {root, Map.put(parent, x, root)}
    end
  end

  def union(parent, a, b) do
    {ra, parent} = find(parent, a)
    {rb, parent} = find(parent, b)

    if ra == rb do
      parent
    else
      Map.put(parent, rb, ra)
    end
  end
end
