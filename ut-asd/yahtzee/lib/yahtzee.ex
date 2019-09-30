defmodule Yahtzee do
  def generate(die_face, occurrences) do
    Enum.to_list(1..6)
    |> List.delete(die_face)
    |> Enum.shuffle
    |> Enum.take(5 - occurrences)
    |> Enum.concat(List.duplicate(die_face, occurrences))
    |> Enum.shuffle
  end

  def enumMap do
    Enum.map(2..6, fn (dice_face) ->
      dices = generate(dice_face, 3)
      IO.puts dices
      Enum.sum(dices)
    end)
  end

  def score_upper(dice) do
    # %{Ones: 1}
    %{Ones: length(Enum.filter(dice, fn e -> e == 1 end)),
      Twos: length(Enum.filter(dice, fn e -> e == 2 end)),
      Threes: length(Enum.filter(dice, fn e -> e == 3 end)),
      Fours: length(Enum.filter(dice, fn e -> e == 4 end)),
      Fives: length(Enum.filter(dice, fn e -> e == 5 end)),
      Sixes: length(Enum.filter(dice, fn e -> e == 6 end))}
  end

  def score_lower(dices) do
    %{"Three of a kind": Enum.sum(dices)}
  end

end
