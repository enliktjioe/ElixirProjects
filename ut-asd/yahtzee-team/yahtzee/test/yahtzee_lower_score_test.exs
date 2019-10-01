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

  def generateSmallStraight(dice_face) when dice_face != 3 and dice_face != 4 do
    Enum.to_list(1..6)
    |> List.delete(dice_face)
    |> Enum.take(5)
    |> Enum.shuffle
  end

  def generateSmallStraight(dice_face) when dice_face == 3 or dice_face == 4 do
    Enum.to_list(1..6)
    |> Enum.take(5)
    |> Enum.shuffle
  end

  def generateLargeStraight(n) when n == 1 do
    Enum.to_list(1..6)
    |> List.delete(1)
    |> Enum.take(5)
    |> Enum.shuffle
  end

  def generateLargeStraight(n) when n == 2 do
    Enum.to_list(1..6)
    |> List.delete(6)
    |> Enum.take(5)
    |> Enum.shuffle
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

  test "Identify 'Small straight' with every face" do
    Enum.map(1..6, fn (dice_face) ->
      dices = generateSmallStraight(dice_face)
      assert %{"Small straight": 30} = Yahtzee.score_lower(dices)
    end)
  end

  test "Identify 'Large straight' with every face" do
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





end

