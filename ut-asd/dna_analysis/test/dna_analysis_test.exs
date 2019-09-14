defmodule DnaAnalysisTest do
  use ExUnit.Case

  # @tag :pending
  test "empty dna string has no adenine" do
    assert DnaAnalysis.count('', ?A) == 0
  end

  @tag :pending
  test "repetitive cytosine gets counted" do
    assert DnaAnalysis.count('CCCCC', ?C) == 5
  end

  @tag :pending
  test "counts only thymine" do
    assert DnaAnalysis.count('GGGGGTAACCCGG', ?T) == 1
  end

  @tag :pending
  test "empty dna string has no nucleotides" do
    expected = %{?A => 0, ?T => 0, ?C => 0, ?G => 0}
    assert DnaAnalysis.histogram('') == expected
  end

  @tag :pending
  test "repetitive sequence has only guanine" do
    expected = %{?A => 0, ?T => 0, ?C => 0, ?G => 8}
    assert DnaAnalysis.histogram('GGGGGGGG') == expected
  end

  @tag :pending
  test "counts all nucleotides" do
    s = 'AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC'
    expected = %{?A => 20, ?T => 21, ?C => 12, ?G => 17}
    assert DnaAnalysis.histogram(s) == expected
  end
end