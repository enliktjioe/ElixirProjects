defmodule GildedRose do
  def increase_quality(item) do
    if item.quality < 50 do
      %{item | quality: item.quality + 1}
    else
      item
    end
  end

  def update_sell_in(item) do
    if (item.name == "Sulfuras, Hand of Ragnaros") do
      item
    else
      %{item | sell_in: item.sell_in - 1}
    end
  end

  def update_sell_in(%{name: "Sulfuras"<>_} = item), do: item
  def update_sell_in(item), do: %{item | sell_in: item.sell_in - 1}

  def update_quality(items) do
    for item <- items do
      item =
      if (item.name != "Aged Brie") and (item.name != "Backstage passes to a TAFKAL80ETC concert") do
        if (item.quality > 0) do
          if (item.name != "Sulfuras, Hand of Ragnaros") do
            %{item | quality: item.quality - 1}
          else
            item
          end
        else
          item
        end
      else
        if (item.quality < 50) do
          itemp = %{item | quality: item.quality + 1}
          if (itemp.name == "Backstage passes to a TAFKAL80ETC concert") do
            itemq =
              if (itemp.sell_in < 11) do
                increase_quality(itemp)
              else
                itemp
              end
            if (itemq.sell_in < 6) do
              increase_quality(itemq)
            else
              itemq
            end
          else
            itemp
          end
        else
          item
        end
      end
      item =
        update_sell_in(item)
      item =
      if (item.sell_in < 0) do
        if (item.name != "Aged Brie") do
          if (item.name != "Backstage passes to a TAFKAL80ETC concert") do
            if item.quality > 0 do
              update_sell_in(item)
            else
              item
            end
          else
            %{item | quality: item.quality - item.quality}
          end
        else
          increase_quality(item)
        end
      else
        item
      end
    end
  end
end
