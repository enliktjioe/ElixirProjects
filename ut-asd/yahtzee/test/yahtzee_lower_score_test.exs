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

  def assert_score(func, dice, expected) do
    assert func.(dice) == expected
    # assert %{"Large straights": 40} = Yahtzee.score_lower(dices)
  end

  def assert_score_func(func) do
    # is there a better way to create partial functions?
    fn dice, expected -> assert_score(func, dice, expected) end
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

  # test "Identify 'Small straights' with every face" do
  #   Enum.map(1..6, fn dice_face ->
  #     dices = generate(dice_face, 1)
  #     assert %{"Small straights": 30} = Yahtzee.score_lower(dices |> Enum.shuffle)
  #   end)
  # end
  test "small straight score is correct" do
    f = assert_score_func(&Yahtzee.score_small_straight/1)
    f.([1,2,3,4,5], 30)
    f.([1,2,3,4,1], 30)
    f.([4,3,2,1,1], 30)
    f.([1,4,3,2,1], 30)
    f.([6,5,4,1,3], 30)
    f.([6,5,2,1,3], 0)
    f.([1,5,4,1,3], 0)
  end


  # test "Identify 'Large straights' with every face" do
  #   Enum.map(1..6, fn dice_face ->
  #     dices = generate(dice_face, 1)
  #     assert %{"Large straights": 40} = Yahtzee.score_lower(dices)
  #   end)
  # end

  test "large straight score is correct" do
    f = assert_score_func(&Yahtzee.score_large_straight/1)
    f.([1,2,5,4,3], 40)
    f.([6,5,3,2,4], 40)
    f.([4,3,2,1,1], 0)
    f.([1,4,3,2,1], 0)
    f.([6,5,4,1,3], 0)
    f.([6,5,2,1,3], 0)
    f.([1,5,4,1,3], 0)
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

  test "Add a corresponding score and the other scored with 0" do
    # items = [ %Item{name: "Conjured Mana Cake ", sell_in: 6, quality: 10},
    #           %Item{name: "Conjured Mana Cake", sell_in: 45, quality: 33}]
    # res = GildedRose.update_items(items)
    # assert res === Enum.map(items, &(%{&1 | sell_in: &1.sell_in - 1, quality: &1.quality - 2}))
    # items = {Chance: ^sum}

  end







end

