defmodule Day6 do
  def part1() do
    sheet =
      Day1.read_txt("day6.txt")
      |> String.split("\n")
      |> Enum.map(fn x -> String.split(x, " ") end)
      |> Enum.map(fn inner ->
        Enum.filter(inner, fn x -> String.length(x) != 0 end)
      end)
      |> Enum.filter(fn x -> length(x) != 0 end)

    opr =
      List.last(sheet)

    num =
      List.delete_at(sheet, -1)
      |> Enum.map(fn inner ->
        Enum.map(inner, fn x -> String.to_integer(x) end)
      end)

    numx =
      num
      |> Enum.with_index()
      |> Enum.map(fn {row, row_i} ->
        Enum.with_index(row)
        |> Enum.map(fn {val, col_i} ->
          {row_i, col_i, val}
        end)
      end)
      |> List.flatten()
      |> Enum.group_by(fn {_, col, _} -> col end)
      |> Enum.map(fn {key, tuples} ->
        values = Enum.map(tuples, fn {_r, _c, v} -> v end)
        {key, values}
      end)
      |> Map.new()

    opr
    |> Enum.with_index()
    |> Enum.map(fn {value, index} ->
      case value do
        "*" -> mul_list(Map.get(numx, index))
        "+" -> Map.get(numx, index) |> Enum.sum()
      end
    end)
    |> Enum.sum()
    |> IO.inspect()
  end

  defp mul_list(listx) do
    listx |> Enum.reduce(fn x, acc -> x * acc end)
  end
end
