defmodule Yahtzee do

  def score_all(dice) do
    score_upper(dice)
    score_lower(dice)
  end

  def score_upper(dice) do
    %{Ones: length(Enum.filter(dice, fn e -> e == 1 end)),
      Twos: length(Enum.filter(dice, fn e -> e == 2 end)),
      Threes: length(Enum.filter(dice, fn e -> e == 3 end)),
      Fours: length(Enum.filter(dice, fn e -> e == 4 end)),
      Fives: length(Enum.filter(dice, fn e -> e == 5 end)),
      Sixes: length(Enum.filter(dice, fn e -> e == 6 end))}
  end

  def score_lower(dice) do
    %{"Three of a kind": scoreN(dice, 3),
      "Four of a kind": scoreN(dice, 4),
      "Full house": scoreFullHouse(dice),
      "Small straight": scoreSmallStraight(dice),
      "Large straight": scoreLargeStraight(dice),
      Yahtzee: scoreYahtzee(dice),
      Chance: scoreChance(dice)
    }
  end

  def scoreN(dice, n) do
    Enum.reduce(1..6, 0, fn x, pattern ->
      case pattern do
        0 -> counts = Enum.count(dice, fn num -> num == x end)
             if counts >= n, do: Enum.sum(dice), else: 0
        _ -> pattern
      end
    end)
  end

  def scoreFullHouse(dice) do
    uniqueList = Enum.uniq(dice)
    case uniqueList do
      [x, _]  -> if Enum.count(dice, fn n -> n == x end) in [3,2], do: 25, else: 0
      _       -> 0
    end
  end

  def scoreSmallStraight(dice), do: (if scoreStraight(dice, smallStrights()), do: 30, else: 0)
  def scoreLargeStraight(dice), do: (if scoreStraight(dice, largeStrights()), do: 40, else: 0)

  def smallStrights, do: [[1,2,3,4],[2,3,4,5],[3,4,5,6]]
  def largeStrights, do: [[1,2,3,4,5], [2,3,4,5,6]]

  def scoreStraight(dice, straightList) do
    checks = for listN <- straightList do
      Enum.map(listN, fn n -> n in dice end) |> Enum.all?
    end
    Enum.any?(checks)
  end

  def scoreYahtzee(dice), do: (if scoreN(dice, 5) != 0, do: 50, else: 0)
  def scoreChance(dice), do: Enum.sum(dice)

  def checkingCombination (dice) do

  end

end
