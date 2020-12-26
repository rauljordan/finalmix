defmodule FinalMix.Detector.Helpers do
  alias FinalMix.Detector.Config
  alias Ethereum.Eth.V1alpha1.IndexedAttestation

  @spec group_by_validator_index(nil) :: map()
  def group_by_validator_index(nil), do: Map.new()

  @spec group_by_validator_index([IndexedAttestation]) :: %{
          required(integer()) => [IndexedAttestation]
        }
  def group_by_validator_index(atts) do
    # Reduce into a map where the keys are
    # validator chunk indices and the values are
    # lists of attestations grouped for that chunk
    Enum.reduce(atts, Map.new(), fn att, acc ->
      subqueue_ids = validator_chunk_indices(att.attesting_indices)

      # For every subqueue id, we append the corresponding
      # grouped attestation into the list of values
      # for that subqueue id in the map
      Enum.reduce(subqueue_ids, acc, fn id, map ->
        {_, map} =
          Map.get_and_update(map, id, fn value ->
            case value do
              nil -> {value, [att]}
              tail -> {value, [att | tail]}
            end
          end)

        map
      end)
    end)
  end

  @spec group_by_chunk_index([IndexedAttestation]) :: %{
          required(integer()) => [IndexedAttestation]
        }
  def group_by_chunk_index(atts) do
    atts_by_chunk = Map.new()

    Enum.reduce(atts, atts_by_chunk, fn att, map ->
      chunk_idx = Config.chunk_index(att.data.source.epoch)

      {_, map} =
        Map.get_and_update(map, chunk_idx, fn value ->
          case value do
            nil -> {value, [att]}
            tail -> {value, [att | tail]}
          end
        end)

      map
    end)
  end

  @spec validator_chunk_indices([integer()]) :: [integer()]
  def validator_chunk_indices(attesting_indices) do
    # Convert a list of attesting indices into
    # a unique set of validator chunk indices
    Enum.map(attesting_indices, fn index ->
      Config.validator_chunk_index(index)
    end)
    |> Enum.uniq()
  end
end
