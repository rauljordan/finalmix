defmodule FinalMixTest.Detector.Helpers do
  use ExUnit.Case
  alias FinalMix.Detector.Helpers
  alias Ethereum.Eth.V1alpha1.IndexedAttestation
  doctest FinalMix

  describe "validator chunk indices" do
    test "unique validator chunk indices from attesting indices" do
      indices = [16, 16, 16, 32]
      wanted = [1, 2]
      assert Helpers.validator_chunk_indices(indices) == wanted
    end
  end

  describe "group by validator index" do
    test "properly groups simple, single attestations" do
      att1 = IndexedAttestation.new(attesting_indices: [16])
      att2 = IndexedAttestation.new(attesting_indices: [32])

      wanted = %{
        1 => [att1],
        2 => [att2]
      }

      assert Helpers.group_by_validator_index([att1, att2]) == wanted
    end

    test "properly groups multiple attestations within same subqueue" do
      att1 = IndexedAttestation.new(attesting_indices: [0])
      att2 = IndexedAttestation.new(attesting_indices: [1])
      att3 = IndexedAttestation.new(attesting_indices: [2])
      att4 = IndexedAttestation.new(attesting_indices: [16])

      wanted = %{
        0 => [att3, att2, att1],
        1 => [att4]
      }

      assert Helpers.group_by_validator_index([att1, att2, att3, att4]) == wanted
    end
  end
end
