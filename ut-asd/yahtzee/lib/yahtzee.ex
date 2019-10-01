defmodule Yahtzee do
  @sides 6
  @num_dice 5

  def score_upper(dice) do
    %{Ones: length(Enum.filter(dice, fn e -> e == 1 end)),
      Twos: 2 * length(Enum.filter(dice, fn e -> e == 2 end)),
      Threes: 3 * length(Enum.filter(dice, fn e -> e == 3 end)),
      Fours: 4 * length(Enum.filter(dice, fn e -> e == 4 end)),
      Fives: 5 * length(Enum.filter(dice, fn e -> e == 5 end)),
      Sixes: 6 * length(Enum.filter(dice, fn e -> e == 6 end))}
  end

  def fixed_scores do
    [ full_house: 25,
      small_straight: 30,
      large_straight: 40,
      yahtzee: 50 ]
  end

  def score_lower(dice) do
    %{"Three of a kind": score_n_of_kind(dice, 3),
      "Four of a kind": score_n_of_kind(dice, 4),
      "Full house": score_full_house(dice),
      "Small straights": score_small_straight(dice),
      "Large straights": score_large_straight(dice),
      Yahtzee: score_yahtzee(dice),
      Chance: score_chance(dice)}
  end

  def score_yahtzee(dice), do: (if score_n_of_kind(dice, 5) != 0, do: fixed_scores[:yahtzee], else: 0)

  def score_n_of_kind(dice, n) do
    1 .. @sides |> Enum.reduce(0,
      fn x, acc ->
        case acc do
          0 -> c = Enum.count(dice, &(&1 == x))
               if c >= n, do: Enum.sum(dice), else: 0
          _ -> acc
        end
      end)
  end

  def score_full_house(dice) do
    unique = dice |> Enum.uniq
    case unique  do
      [a, _] -> if Enum.count(dice, &(&1 == a)) in [2,3], do: fixed_scores[:full_house], else: 0
      _ -> 0
    end
  end

  # Code Reference
  # https://github.com/dwelve/elixir-yahtzee/blob/master/lib/yahtzee.ex
  def score_small_straight(dice), do: (if score_straight(dice, small_straights), do: fixed_scores[:small_straight], else: 0)
  def score_large_straight(dice), do: (if score_straight(dice, large_straights), do: fixed_scores[:large_straight], else: 0)

  def small_straights, do: [[1,2,3,4],[2,3,4,5],[3,4,5,6]]
  def large_straights, do: [[1,2,3,4,5], [2,3,4,5,6]]
  def score_straight(dice, straights) do
    # alternatively, sort unique items and compare against straights items
    checks = for ss <- straights do
      Enum.map(ss, &(&1 in dice)) |> Enum.all?
    end
    Enum.any?(checks)
  end

  def score_chance(dice), do: Enum.sum(dice)

end
