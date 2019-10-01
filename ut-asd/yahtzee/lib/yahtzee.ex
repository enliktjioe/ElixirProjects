defmodule Yahtzee do
  def generate(die_face, occurrences) do
    Enum.to_list(1..6)
    |> List.delete(die_face)
    |> Enum.shuffle
    |> Enum.take(5 - occurrences)
    |> Enum.concat(List.duplicate(die_face, occurrences))
    |> Enum.shuffle
  end

  def threeOfKinds do
    Enum.map(2..6, fn (dice_face) ->
      dices = generate(dice_face, 3)
      IO.puts dices
      Enum.sum(dices)
    end)
  end

  def fullHouse do
    Enum.map(1..6, fn _ ->
      [x,y] =
        Enum.shuffle(1..6)
        |> Enum.take(2)

      # IO.puts [x,y]
      # IO.puts [x,x,x,y,y]

      # test = Yahtzee.score_lower([x,x,x,y,y] |> Enum.shuffle)
    end)
  end

  def smallStraight do
    Enum.map(1..6, fn _ ->
      [a,b,c,d,e] =
        Enum.shuffle(1..6)
        |> Enum.take(5)
    end)
  end

  # Code Reference
  # https://github.com/dwelve/elixir-yahtzee/blob/master/lib/yahtzee.ex
  # def small_straights do
  #   [[1,2,3,4],[2,3,4,5],[3,4,5,6]]
  # end

  # def large_straights do
  #   [[1,2,3,4,5], [2,3,4,5,6]]
  # end

  # def score_straight(dice, straights) do
  #   # alternatively, sort unique items and compare against straights items
  #   checks = for ss <- straights do
  #     Enum.map(ss, &(&1 in dice)) |> Enum.all?
  #   end
  #   Enum.any?(checks)
  # end




  def score_upper(dice) do
    %{Ones: length(Enum.filter(dice, fn e -> e == 1 end)),
      Twos: 2 * length(Enum.filter(dice, fn e -> e == 2 end)),
      Threes: 3 * length(Enum.filter(dice, fn e -> e == 3 end)),
      Fours: 4 * length(Enum.filter(dice, fn e -> e == 4 end)),
      Fives: 5 * length(Enum.filter(dice, fn e -> e == 5 end)),
      Sixes: 6 * length(Enum.filter(dice, fn e -> e == 6 end))}
  end

  def score_lower(dices) do
    %{"Three of a kind": Enum.sum(dices),
      "Four of a kind": Enum.sum(dices),
      "Full house": 25,
      "Small straights": 30,
      "Large straights": 40,
      Yahtzee: 50,
      Chance: Enum.sum(dices)}
  end

end
