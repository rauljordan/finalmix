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
    pairs =
      Enum.flat_map(atts, fn att ->
        Enum.map(att.attesting_indices, &{&1, att})
      end)

    transformed_pairs =
      Enum.map(pairs, fn {val_idx, list} ->
        {Config.validator_chunk_index(val_idx), list}
      end)

    Enum.group_by(transformed_pairs, fn {key, _} -> key end, fn {_, list} -> list end)
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
    transformed_pairs =
      Enum.map(atts, fn att ->
        {Config.chunk_index(att.data.source.epoch), att}
      end)
    Enum.group_by(transformed_pairs, fn {key, _} -> key end, fn {_, val} -> val end)
  end
end
