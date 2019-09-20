defmodule BowlingTest do
  use ExUnit.Case

  test "gutter game" do
    game = List.duplicate([0, 0], 9) ++ [[0, 0, nil]]
    assert Bowling.score(game) == 0
  end

  test "'all ones' game" do
    game = List.duplicate([1, 1], 9) ++ [[1, 1, nil]]
    assert Bowling.score(game) == 20
  end

  test "one spare" do
    game = [[5,5],[3,0]] ++ List.duplicate([0, 0], 7) ++ [[0, 0, nil]]
    assert Bowling.score(game) == 16
    # the score for the frame is 10 plus the number of pins knocked down in the first turn of the next frame.
  end

  test "one strike" do
    game = [[10,nil],[3,4]] ++ List.duplicate([0, 0], 7) ++ [[0, 0, nil]]
    assert Bowling.score(game) == 24
  end

  test "perfect game" do
    game = List.duplicate([10,nil], 9) ++ [[10,10,10]]
    assert Bowling.score(game) == 300
  end
end
