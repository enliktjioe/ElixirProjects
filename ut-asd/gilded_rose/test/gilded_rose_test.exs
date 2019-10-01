defmodule GildedRoseTest do
  use ExUnit.Case

  test "At the end of each day our system lowers both values for every item" do
    item = %Item{name: "+5 Dexterity Vest", sell_in: 10, quality: 20}
    [updated_item] = GildedRose.update_quality([item])
    assert updated_item.sell_in == item.sell_in - 1
    assert updated_item.quality == item.quality - 1
  end

end
