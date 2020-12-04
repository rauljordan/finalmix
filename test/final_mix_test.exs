defmodule FinalMixTest do
  use ExUnit.Case
  doctest FinalMix

  test "greets the world" do
    assert FinalMix.hello() == :world
  end
end
