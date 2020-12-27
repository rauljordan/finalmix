defmodule FinalMixTest.Detector do
  use ExUnit.Case
  alias FinalMix.Detector
  alias FinalMix.Detector.Helpers
  alias FinalMix.Detector.Config
  alias Ethereum.Eth.V1alpha1.IndexedAttestation
  alias Ethereum.Eth.V1alpha1.AttestationData
  alias Ethereum.Eth.V1alpha1.Checkpoint
  doctest FinalMix

  describe "update arrays" do
    test "properly groups simple, single attestations" do
      att1 = %IndexedAttestation{
        attesting_indices: [0],
        data: %AttestationData{
          source: %Checkpoint{
            epoch: Config.start_epoch_from_chunk_index(0)
          }
        }
      }

      att2 = %IndexedAttestation{
        attesting_indices: [0],
        data: %AttestationData{
          source: %Checkpoint{
            epoch: Config.start_epoch_from_chunk_index(1)
          }
        }
      }

      chunked_atts = Helpers.group_by_chunk_index([att1, att2])

      # IO.inspect chunked_atts
      IO.inspect(Detector.update_arrays(0, chunked_atts))
    end
  end
end
