defmodule FinalMixTest.Detector.Helpers do
  use ExUnit.Case
  alias FinalMix.Detector.Helpers
  alias Ethereum.Eth.V1alpha1.IndexedAttestation
  doctest FinalMix

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

    test "advanced properly groups multiple attestations" do
      att1 = IndexedAttestation.new(attesting_indices: [0])
      att2 = IndexedAttestation.new(attesting_indices: [0])
      att3 = IndexedAttestation.new(attesting_indices: [1])
      att4 = IndexedAttestation.new(attesting_indices: [2])
      att5 = IndexedAttestation.new(attesting_indices: [16])
      att6 = IndexedAttestation.new(attesting_indices: [17])

      wanted = %{
        0 => [att1, att2, att3, att4],
        1 => [att5, att6]
      }

      assert Helpers.advanced_group_by_validator_index([att1, att2, att3, att4, att5, att6]) == wanted
    end
  end
end
