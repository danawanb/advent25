defmodule Day1 do
  def day1 do
    # part1
    read_txt("day1.txt")
    |> String.split("\n")
    |> Enum.filter(fn x -> String.length(x) != 0 end)
    |> Enum.map(fn x -> String.split_at(x, 1) end)
    |> Enum.reduce({50, 0}, fn x, {acc, total} -> click_day1part1(acc, x, total) end)
    |> IO.inspect()
  end

  def click_day1part1(cur, value_tupple, cur_zero) do
    value =
      elem(value_tupple, 1)
      |> Integer.parse()
      |> elem(0)

    curtotal =
      case elem(value_tupple, 0) do
        "L" ->
          rotate_left(cur, value)

        "R" ->
          rotate_right(cur, value)
      end

    # part 1
    if curtotal == 0 do
      {curtotal, cur_zero + 1}
    else
      {curtotal, cur_zero}
    end
  end

  def rotate_right(cur, val) do
    res = cur + val
    rotate_right2(res)
  end

  def rotate_right2(val) when val > 99 do
    rotate_right2(val - 100)
  end

  def rotate_right2(val), do: val

  def rotate_left(cur, val) do
    res = cur - val
    rotate_left2(res)
  end

  def rotate_left2(val) when val < 0 do
    rotate_left2(val + 100)
  end

  def rotate_left2(val), do: val

  def read_txt(name) do
    filex = File.read!("./lib/#{name}")
    filex
  end
end
