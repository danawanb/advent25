defmodule Day2 do
  def day2_part1() do
    Day1.read_txt("day2.txt")
    |> String.replace("\n", "")
    |> String.split(",")
    |> Enum.filter(fn x -> String.length(x) != 0 end)
    |> Enum.map(fn x -> String.split(x, "-") end)
    |> Enum.map(fn [x, y] -> to_num_list(x, y) end)
    |> Enum.map(fn inner ->
      Enum.filter(inner, fn val -> is_valid(val) == true end)
    end)
    |> Enum.flat_map(fn x -> x end)
    |> Enum.map(fn x -> String.to_integer(x) end)
    |> Enum.reduce(fn x, acc -> x + acc end)
    |> IO.inspect()
  end

  # failed
  def day2_part2() do
    Day1.read_txt("day2.txt")
    |> String.replace("\n", "")
    |> String.split(",")
    |> Enum.filter(fn x -> String.length(x) != 0 end)
    |> Enum.map(fn x -> String.split(x, "-") end)
    |> Enum.map(fn [x, y] -> to_num_list(x, y) end)
    |> Enum.map(fn inner ->
      Enum.filter(inner, fn val -> is_valid2(val) == true end)
    end)
    |> Enum.flat_map(fn x -> x end)
    |> Enum.map(fn x -> String.to_integer(x) end)
    |> Enum.reduce(fn x, acc -> x + acc end)
    |> IO.inspect()
  end

  def to_num_list(x, y) do
    {a, _} = Integer.parse(x)
    {b, _} = Integer.parse(y)

    a..b
    |> Enum.map(fn x -> to_string(x) end)
  end

  def is_valid(val) do
    idx =
      (String.length(val) / 2)
      |> trunc()

    {x, y} =
      val
      |> String.split_at(idx)

    if String.equivalent?(x, y) do
      true
    else
      false
    end
  end

  def is_valid2(val) do
    if repeats(val) >= 2 do
      true
    else
      false
    end
  end

  def repeats(val) do
    n = String.length(val)
    res_lps = lps(val)

    k = List.last(res_lps)
    pattern_length = n - k

    (n / pattern_length) |> trunc()
  end

  def lps(pattern) do
    chars = String.to_charlist(pattern)

    res =
      build_lps(chars, 1, 0, :array.new(length(chars), default: 0))

    res |> :array.to_list()
  end

  def build_lps(chars, i, _len, lps) when i == length(chars), do: lps

  def build_lps(chars, i, len, lps) do
    cond do
      Enum.at(chars, i) == Enum.at(chars, len) ->
        len = len + 1
        lps = :array.set(i, len, lps)
        build_lps(chars, i + 1, len, lps)

      len != 0 ->
        build_lps(chars, i, :array.get(len - 1, lps), lps)

      true ->
        lps = :array.set(i, 0, lps)
        build_lps(chars, i + 1, 0, lps)
    end
  end
end
