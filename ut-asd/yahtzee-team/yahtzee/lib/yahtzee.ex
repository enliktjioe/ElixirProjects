defmodule Yahtzee do

  def score_all(dice) do
    upper = score_upper(dice)
    lower = score_lower(dice)
    Map.merge(upper, lower)
  end

  def countLength(dice, x) do
    dice |> Enum.filter(fn e -> e == x end) |> length()
  end
  def score_upper(dice) do
    %{Ones: countLength(dice,1),
      Twos: countLength(dice, 2),
      Threes: countLength(dice, 3),
      Fours: countLength(dice, 4),
      Fives: countLength(dice, 5),
      Sixes: countLength(dice, 6)}
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

  def scoreSmallStraight(dice) do
    if isStraight(dice, largeStraightsPattern()) == false do
      if isStraight(dice, smallStraightsPattern()), do: 30, else: 0
    else
      0
    end
  end

  def scoreLargeStraight(dice), do: (if isStraight(dice, largeStraightsPattern()), do: 40, else: 0)

  def smallStraightsPattern, do: [[1,2,3,4],[2,3,4,5],[3,4,5,6]]
  def largeStraightsPattern, do: [[1,2,3,4,5], [2,3,4,5,6]]

  def isStraight(dice, straightType) do
    checks = for listN <- straightType do
      Enum.map(listN, fn n -> n in dice end) |> Enum.all?
    end
    Enum.any?(checks)
  end

  def scoreYahtzee(dice), do: (if scoreN(dice, 5) != 0, do: 50, else: 0)

  def scoreChance(dice) do
    cond do
      scoreN(dice, 3) > 0           -> 0
      scoreN(dice, 4) > 0           -> 0
      scoreFullHouse(dice) > 0      -> 0
      scoreSmallStraight(dice) > 0  -> 0
      scoreLargeStraight(dice) > 0  -> 0
      scoreYahtzee(dice) > 0        -> 0
      true                          -> Enum.sum(dice)
    end
  end

end
