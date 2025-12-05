defmodule AdventTest do
  use ExUnit.Case
  doctest Advent

  test "greets the world" do
    assert Advent.hello() == :world
  end

  test "advent of code" do
    # Day1.day1()
    # Day2.day2_part1()
    # Day2.day2_part2()

    # Day3.part1()
    # Day4.part1()
    # Day4.part2()
    Day5.part1()
  end
end
