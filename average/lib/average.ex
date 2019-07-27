# Write a function that computes the average of an input list of numbers
# You can use any of the three functions presented here (i.e. foldl, map, filter)

defmodule Average do
  def createListNumber do
    [1, 5, 7, 3, 2]
  end

  def computeAverage(listNumber) do
    Enum.sum(listNumber) / length(listNumber)
  end
end
