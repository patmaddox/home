defmodule ExampleBundledAppTest do
  use ExUnit.Case
  doctest ExampleBundledApp

  test "greets the world" do
    assert ExampleBundledApp.hello() == :world
  end
end
