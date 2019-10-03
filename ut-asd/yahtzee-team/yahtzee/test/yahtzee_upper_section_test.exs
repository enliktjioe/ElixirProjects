defmodule YahtzeeUpperSectionTest do
  use ExUnit.Case
  doctest Yahtzee

  def generate(die_face, occurrences) do
    Enum.to_list(1..6)
    |> List.delete(die_face)
    |> Enum.shuffle
    |> Enum.take(5 - occurrences)
    |> Enum.concat(List.duplicate(die_face, occurrences))
    |> Enum.shuffle
  end

  def generateRandomDices(dice_face) do
    Enum.reduce(1..4, [dice_face], fn(_, acc) ->
      Enum.shuffle(1..6) |> Enum.take(1) |> Enum.concat(acc)
    end)
  end

  test "works with 1 one" do
    assert %{Ones: 1} = Yahtzee.score_upper([1,2,3,4,5])
  end

  test "works with any combination of dice, containing 1-5 ones" do
    Enum.map(1..5, fn n -> assert %{Ones: ^n} = Yahtzee.score_upper(generate(1, n)) end)
  end

  test "works with twos" do
    Enum.map(1..5, fn n -> assert %{Twos: ^n} = Yahtzee.score_upper(generate(2, n)) end)
  end

  test "works on upper section, with all the other cases" do
    Enum.map(1..5, fn n -> assert %{Threes: ^n} = Yahtzee.score_upper(generate(3, n)) end)
    Enum.map(1..5, fn n -> assert %{Fours: ^n} = Yahtzee.score_upper(generate(4, n)) end)
    Enum.map(1..5, fn n -> assert %{Fives: ^n} = Yahtzee.score_upper(generate(5, n)) end)
    Enum.map(1..5, fn n -> assert %{Sixes: ^n} = Yahtzee.score_upper(generate(6, n)) end)
  end

  test "Identify corresponding score upper" do
    Enum.map(1..6, fn dice_face ->
      dices = generateRandomDices(dice_face)
      mapList = Yahtzee.score_upper(dices)

      cond do
        mapList[:Ones] == 5 ->
          assert mapList[Twos] == 0
          assert mapList[Threes] == 0
          assert mapList[Fours] == 0
          assert mapList[Fives] == 0
          assert mapList[Sixes] == 0

        mapList[:Twos] == 5 ->
          assert mapList[Ones] == 0
          assert mapList[Threes] == 0
          assert mapList[Fours] == 0
          assert mapList[Fives] == 0
          assert mapList[Sixes] == 0


        mapList[:Threes] == 5 ->
          assert mapList[Ones] == 0
          assert mapList[Twos] == 0
          assert mapList[Fours] == 0
          assert mapList[Fives] == 0
          assert mapList[Sixes] == 0

        mapList[:Fours] == 5 ->
          assert mapList[Ones] == 0
          assert mapList[Twos] == 0
          assert mapList[Threes] == 0
          assert mapList[Fives] == 0
          assert mapList[Sixes] == 0

        mapList[:Fives] == 5 ->
          assert mapList[Ones] == 0
          assert mapList[Twos] == 0
          assert mapList[Threes] == 0
          assert mapList[Fours] == 0
          assert mapList[Sixes] == 0

        mapList[:Sixes] == 6 ->
          assert mapList[Ones] == 0
          assert mapList[Twos] == 0
          assert mapList[Threes] == 0
          assert mapList[Fours] == 0
          assert mapList[Fives] == 0

        true ->
          assert mapList[Ones] >= 0
          assert mapList[Twos] >= 0
          assert mapList[Threes] >= 0
          assert mapList[Fours] >= 0
          assert mapList[Fives] >= 0
          assert mapList[Sixes] >= 0
      end
    end)
  end


end

