defmodule YahtzeeLowerScoreTest do
  use ExUnit.Case

  def generate(dice_face, occurrences) do
    Enum.to_list(1..6)
    |> List.delete(dice_face)
    |> Enum.shuffle
    |> Enum.take(5 - occurrences)
    |> Enum.concat(List.duplicate(dice_face, occurrences))
    |> Enum.shuffle
  end

  def generateSmallStraight(n) do
    case n do
      1  -> [1,2,3,4] ++ [Enum.random([1,2,3,4,6])] |> Enum.shuffle
      2  -> [2,3,4,5] ++ [Enum.random([2,3,4,5])]   |> Enum.shuffle
      3  -> [3,4,5,6] ++ [Enum.random([1,3,4,5,6])] |> Enum.shuffle
      _  -> [1,2,3,4,1]
    end
  end

  def generateLargeStraight(n) do
    case n do
      1  -> [1,2,3,4,5] |> Enum.shuffle
      2  -> [2,3,4,5,6] |> Enum.shuffle
      _  -> [1,2,3,4,5]
    end
  end

  def generateRandomDices(dice_face) do
    Enum.reduce(1..4, [dice_face], fn(_, acc) ->
      Enum.shuffle(1..6) |> Enum.take(1) |> Enum.concat(acc)
    end)
  end

  test "Identify 'Three of a kind' with ones" do
    dices = generate(1, 3)
    sum = Enum.sum(dices)
    assert %{"Three of a kind": ^sum} = Yahtzee.score_lower(dices)
  end

  test "Identify 'Three of a kind' with all the others" do
    Enum.map(2..6, fn (dice_face) ->
      dices = generate(dice_face, 3)
      sum = Enum.sum(dices)
      assert %{"Three of a kind": ^sum} = Yahtzee.score_lower(dices)
    end)
  end

  test "Identify 'Four of a kind' with every face" do
    Enum.map(1..6, fn (dice_face) ->
      dices = generate(dice_face, 4)
      sum = Enum.sum(dices)
      assert %{"Four of a kind": ^sum} = Yahtzee.score_lower(dices)
    end)
  end

  test "Identify 'Full house' with every face" do
    Enum.map(1..6, fn _ ->
      [x,y] =
        Enum.shuffle(1..6)
        |> Enum.take(2)
      assert %{"Full house": 25} = Yahtzee.score_lower([x,x,x,y,y] |> Enum.shuffle)
    end)
  end

  test "Identify 'Small straight' with all possibilities" do
    Enum.map(1..3, fn (n) ->
      dices = generateSmallStraight(n)
      assert %{"Small straight": 30} = Yahtzee.score_lower(dices)
    end)
  end

  test "Identify 'Large straight' with all possibilities" do
    Enum.map(1..2, fn (n) ->
      dices = generateLargeStraight(n)
      assert %{"Large straight": 40} = Yahtzee.score_lower(dices)
    end)
  end

  test "Identify 'Yahtzee'" do
    Enum.map(1..6, fn n ->
      assert %{Yahtzee: 50} = Yahtzee.score_lower(List.duplicate(n,5))
    end)
  end

  test "Identify any other combination" do
    Enum.map(1..6, fn _ ->
      [x,y,z] =
        Enum.shuffle(1..6)
        |> Enum.take(3)
      seq = Enum.shuffle([x,x,y,y,z])
      sum = Enum.sum(seq)
      assert %{Chance: ^sum} = Yahtzee.score_lower(seq)
    end)
  end

  test "Identify corresponding score lower" do
    Enum.map(1..6, fn dice_face ->
      dices = generateRandomDices(dice_face)
      mapList = Yahtzee.score_lower(dices)

      cond do
        mapList[:Chance] > 0 ->
          assert mapList[:"Three of a kind"] == 0
          assert mapList[:"Four of a kind"] == 0
          assert mapList[:"Full house"] == 0
          assert mapList[:"Small straight"] == 0
          assert mapList[:"Large straight"] == 0
          assert mapList[:Yahtzee] == 0

        mapList[:"Three of a kind"] > 0 ->
          assert mapList[:Chance] == 0
          assert mapList[:"Small straight"] == 0
          assert mapList[:"Large straight"] == 0

        mapList[:"Four of a kind"] > 0 ->
          assert mapList[:Chance] == 0
          assert mapList[:"Full house"] == 0
          assert mapList[:"Small straight"] == 0
          assert mapList[:"Large straight"] == 0

        mapList[:"Full house"] > 0 ->
          assert mapList[:Chance] == 0
          assert mapList[:"Small straight"] == 0
          assert mapList[:"Large straight"] == 0
          assert mapList[:Yahtzee] == 0

        mapList[:"Small straight"] > 0 ->
          assert mapList[:Chance] == 0
          assert mapList[:"Three of a kind"] == 0
          assert mapList[:"Four of a kind"] == 0
          assert mapList[:"Full house"] == 0
          assert mapList[:"Large straight"] == 0
          assert mapList[:Yahtzee] == 0

        mapList[:"Large straight"] > 0 ->
          assert mapList[:Chance] == 0
          assert mapList[:"Three of a kind"] == 0
          assert mapList[:"Four of a kind"] == 0
          assert mapList[:"Full house"] == 0
          assert mapList[:"Small straight"] == 0
          assert mapList[:Yahtzee] == 0

        mapList[:Yahtzee] > 0 ->
          assert mapList[:Chance] == 0
          assert mapList[:"Full house"] == 0
          assert mapList[:"Small straight"] == 0
          assert mapList[:"Large straight"] == 0
      end
    end)
  end





end

