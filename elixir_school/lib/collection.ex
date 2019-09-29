defmodule Collection do
  # COLLECTION
  # http://elixirschool.com/en/lessons/basics/collections/

  ## List
  def learnList do
    list = [3.14, :pie, "Apple"]
    ["π" | list]
    list ++ ["Cherry"]
    # [3.14, :pie, "Apple", "Cherry"]
  end

  ### List Concatenation
  def listConcat do
    [1, 2] ++ [3, 4, 1]
    # [1, 2, 3, 4, 1]
  end

  ### List Substraction
  def listSubtract do
    [1,2,2,3,2,3] -- [1,2,3,2]
    # [2, 3]
  end

  ## Head/Tail
  def headTail do
    hd ["game", :test, 50]
    # "game"
    tl ["game", :test, 50]
    # :test, 50
  end

  def simplePatternMatching do
    [head | tail] = ["game", :test, 50]
    # ["game", :test, 50]

    head
    # "game"

    tail
    # :test, 50
  end

  ## Tuples
  def learnTuples do
    {3.14, :pie, "Apple"}
    # {3.14, :pie, "Apple"}
  end

  # It is common for tuples to be used as a mechanism to return additional information from functions;
  # the usefulness of this will be more apparent when we get into pattern matching:
  def commonTuplesOutput do
    File.read("lib/collection.ex")
    # {:ok, "...contents..."}

    File.read("missing/path")
    # {:error, :enoent}
  end

  ## Keyword List
  def keywordList do
    # Keyword lists and maps are the associative collections of Elixir.
    # In Elixir, a keyword list is a special list of two-element tuples whose first element is an atom;
    # they share performance with lists
    [foo: "bar", hello: "world"]
    # [foo: "bar", hello: "world"]

    [{:foo, "bar"}, {:hello, "world"}]
    # [foo: "bar", hello: "world"]
  end

  ## Maps
  def learnMap do
    # In Elixir, maps are the “go-to” key-value store. Unlike keyword lists,
    # they allow keys of any type and are un-ordered. You can define a map with the %{} syntax:

    map = %{:foo => "bar", "hello" => :world}
    # %{:foo => "bar", "hello" => :world}

    map[:foo]
    # "bar"

    map["hello"]
    # :world

    map["bar"]
    # nil

    # As of Elixir 1.2, variables are allowed as map keys:
    key = "hello"
    # "hello"

    %{key => "world"}
    # %{"hello" => "world"}

    # If a duplicate is added to a map, it will replace the former value:
    %{:foo => "bar", :foo => "hello world"}
    # %{foo: "hello world"}

    %{foo: "bar", hello: "world"}
    # %{foo: "bar", hello: "world"}

    %{foo: "bar", hello: "world"} == %{:foo => "bar", :hello => "world"}
    # true

    map = %{foo: "bar", hello: "world"}
    # %{foo: "bar", hello: "world"}

    map.hello
    # "world"

    # Another interesting property of maps is that they provide their own syntax for updates
    # (note: this creates a new map)
    map = %{foo: "bar", hello: "world"}
    # %{foo: "bar", hello: "world"}

    %{map | foo: "baz"}
    %{foo: "baz", hello: "world"}
  end




end
