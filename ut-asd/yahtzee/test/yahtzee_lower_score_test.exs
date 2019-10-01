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

  # Code Reference
  # https://github.com/dwelve/elixir-yahtzee/blob/master/lib/yahtzee.ex
  def small_straights do
    [[1,2,3,4],[2,3,4,5],[3,4,5,6]]
  end

  def large_straights do
    [[1,2,3,4,5], [2,3,4,5,6]]
  end

  def score_straight(dice, straights) do
    # alternatively, sort unique items and compare against straights items
    checks = for ss <- straights do
      Enum.map(ss, &(&1 in dice)) |> Enum.all?
    end
    Enum.any?(checks)
  end

  test "Identify 'Small straights' with every face" do
    Enum.map(1..6, fn _ ->
      [a,b,c,d] =
        Enum.shuffle(1..6)
        |> Enum.take(4)
      assert %{"Small straights": 30} = Yahtzee.score_lower([a,b,c,d] |> Enum.shuffle)
    end)
  end


  test "Identify 'Large straights' with every face" do
    Enum.map(1..6, fn _ ->
      [a,b,c,d,e] =
        Enum.shuffle(1..6)
        |> Enum.take(5)
      assert %{"Large straights": 40} = Yahtzee.score_lower([a,b,c,d,e] |> Enum.shuffle)
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

