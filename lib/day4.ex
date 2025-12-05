defmodule Day4 do
  def part1() do
    matrix =
      Day1.read_txt("day4.txt")
      |> String.split("\n")
      |> Enum.filter(fn x -> String.length(x) != 0 end)
      |> Enum.map(&String.graphemes/1)

    matrix
    |> Enum.with_index()
    |> Enum.map(fn {inner_list, outer_index} ->
      inner_list
      |> Enum.with_index()
      |> Enum.map(fn {_item, inner_index} ->
        # {outer_index, inner_index, item}
        if direction_exist(outer_index, inner_index, matrix) == 1 do
          if matrix |> Enum.at(outer_index) |> Enum.at(inner_index) == "@" do
            1
          else
            0
          end
        else
          0
        end
      end)
    end)
    |> List.flatten()
    |> Enum.sum()
    |> IO.inspect()
  end

  def part2() do
    matrix =
      Day1.read_txt("day4.txt")
      |> String.split("\n")
      |> Enum.filter(fn x -> String.length(x) != 0 end)
      |> Enum.map(&String.graphemes/1)

    update_list =
      matrix
      |> Enum.with_index()
      |> Enum.map(fn {inner_list, outer_index} ->
        inner_list
        |> Enum.with_index()
        |> Enum.map(fn {_item, inner_index} ->
          if direction_exist(outer_index, inner_index, matrix) == 1 do
            if matrix |> Enum.at(outer_index) |> Enum.at(inner_index) == "@" do
              {outer_index, inner_index}
            end
          end
        end)
      end)
      |> List.flatten()
      |> Enum.filter(fn x -> x != nil end)

    recursive_update(matrix, length(update_list))
  end

  def recursive_update(matrix, n) when n > 0 do
    update_list =
      matrix
      |> Enum.with_index()
      |> Enum.map(fn {inner_list, outer_index} ->
        inner_list
        |> Enum.with_index()
        |> Enum.map(fn {_item, inner_index} ->
          if direction_exist(outer_index, inner_index, matrix) == 1 do
            if matrix |> Enum.at(outer_index) |> Enum.at(inner_index) == "@" do
              {outer_index, inner_index}
            end
          end
        end)
      end)
      |> List.flatten()
      |> Enum.filter(fn x -> x != nil end)

    res =
      Enum.reduce(update_list, matrix, fn {r, c}, acc ->
        update_matrix_value(acc, r, c)
      end)

    recursive_update(res, length(update_list))
  end

  def recursive_update(matrix, 0) do
    matrix
    |> Enum.map(fn inner ->
      Enum.filter(inner, fn val -> val == "x" end)
    end)
    |> List.flatten()
    |> length()
    |> IO.inspect()
  end

  defp update_matrix_value(matrix, row, col) do
    List.update_at(matrix, row, fn r ->
      List.update_at(r, col, fn _old -> "x" end)
    end)
  end

  defp direction_exist(outer_index, inner_index, item) do
    val =
      [
        top(outer_index, inner_index, item),
        left(outer_index, inner_index, item),
        # topright(outer_index, inner_index, item)
        down(outer_index, inner_index, item),
        right(outer_index, inner_index, item),
        topright(outer_index, inner_index, item),
        topleft(outer_index, inner_index, item),
        downleft(outer_index, inner_index, item),
        downright(outer_index, inner_index, item)
      ]
      |> Enum.count(& &1) < 4

    if val == true do
      1
    else
      0
    end
  end

  defp top(outer_index, inner_index, item) do
    val =
      if outer_index - 1 < 0 do
        false
      else
        item |> Enum.at(outer_index - 1) |> Enum.at(inner_index)
      end

    case val do
      "@" -> true
      _ -> false
    end
  end

  defp left(outer_index, inner_index, item) do
    val =
      if inner_index - 1 < 0 do
        false
      else
        item |> Enum.at(outer_index) |> Enum.at(inner_index - 1)
      end

    case val do
      "@" -> true
      _ -> false
    end
  end

  defp down(outer_index, inner_index, item) do
    val =
      if outer_index + 1 > length(item) - 1 do
        false
      else
        item |> Enum.at(outer_index + 1) |> Enum.at(inner_index)
      end

    case val do
      "@" -> true
      _ -> false
    end
  end

  defp right(outer_index, inner_index, item) do
    val =
      if inner_index + 1 > length(Enum.at(item, 0)) - 1 do
        false
      else
        item |> Enum.at(outer_index) |> Enum.at(inner_index + 1)
      end

    case val do
      "@" -> true
      _ -> false
    end
  end

  defp topright(outer_index, inner_index, item) do
    val =
      if outer_index - 1 < 0 or inner_index + 1 > length(Enum.at(item, 0)) - 1 do
        false
      else
        item |> Enum.at(outer_index - 1) |> Enum.at(inner_index + 1)
      end

    case val do
      "@" -> true
      _ -> false
    end
  end

  defp downright(outer_index, inner_index, item) do
    val =
      if outer_index + 1 > length(item) - 1 or inner_index + 1 > length(Enum.at(item, 0)) - 1 do
        false
      else
        item |> Enum.at(outer_index + 1) |> Enum.at(inner_index + 1)
      end

    case val do
      "@" -> true
      _ -> false
    end
  end

  defp downleft(outer_index, inner_index, item) do
    val =
      if outer_index + 1 > length(item) - 1 or inner_index - 1 < 0 do
        false
      else
        item |> Enum.at(outer_index + 1) |> Enum.at(inner_index - 1)
      end

    case val do
      "@" -> true
      _ -> false
    end
  end

  defp topleft(outer_index, inner_index, item) do
    val =
      if outer_index - 1 < 0 or inner_index - 1 < 0 do
        false
      else
        item |> Enum.at(outer_index - 1) |> Enum.at(inner_index - 1)
      end

    case val do
      "@" -> true
      _ -> false
    end
  end
end
