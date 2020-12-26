defmodule FinalMix.Detector.Helpers do
  alias FinalMix.Detector.Config
  alias Ethereum.Eth.V1alpha1.IndexedAttestation

  @doc """
  Groups a list of indexed attestations into a map
  where each key is a validator chunk index and the values
  are list of attestations for that validator chunk index.
  A validator chunk index is determined by floor dividing
  a validator index by the number of elements in
  chunks (Default: 16 elements per chunk).

  ## Example

      iex> attestations = [
        %IndexedAttestation{attesting_indices: [0]},
        %IndexedAttestation{attesting_indices: [16]},
      ]
      iex> group_by_validator_chunk_index(attestations)
      %{
        0 => [%IndexedAttestation{attesting_indices: [0]}],
        1 => [%IndexedAttestation{attesting_indices: [16]}],
      }

  """
  @spec group_by_validator_chunk_index([IndexedAttestation]) :: %{
          required(integer()) => [IndexedAttestation]
        }
  def group_by_validator_chunk_index(atts) do
    # Group into a map where the keys are
    # validator chunk indices and the values are
    # lists of attestations grouped for a validator chunk index
    group_attestations_by(
      atts,
      # Select attesting indices
      fn att -> att.attesting_indices end,
      # Transform each into a validator chunk idx
      fn validator_idx ->
        Config.validator_chunk_index(validator_idx)
      end
    )
  end

  @doc """
  Groups a list of indexed attestations into a map
  where each key is an epoch chunk index and the values
  are list of attestations for that epoch chunk index.
  A chunk index is determined by taking an attestation's
  (source epoch % HISTORY_SIZE) and floor dividing by
  the number of elements in chunks (Default: 16 elements per chunk).
  """
  @spec group_by_chunk_index([IndexedAttestation]) :: %{
          required(integer()) => [IndexedAttestation]
        }
  def group_by_chunk_index(atts) do
    # Group into a map where the keys are
    # chunk indices for source epochs and the values are
    # lists of attestations grouped for that chunk index
    group_attestations_by(
      atts,
      # Select source epoch
      fn att -> att.data.source.epoch end,
      # Transform each source epoch into a chunk index
      fn epoch -> Config.chunk_index(epoch) end
    )
  end

  # Groups attestations into a map where for each, we select
  # a field from the attestation, then we transform the field
  # and group attestations into lists for each of those fields
  defp group_attestations_by(atts, select_field, transform_field) do
    pairs = Enum.flat_map atts, fn att ->
      Enum.map(select_field.(att), &{&1, att})
    end
    transformed_pairs = Enum.map pairs, fn {key, val} ->
      {transform_field.(key), val}
    end
    Enum.group_by transformed_pairs, fn {key, _} -> key end, fn {_, val} -> val end
  end
end
