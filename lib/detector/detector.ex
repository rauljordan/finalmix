defmodule FinalMix.Detector do
  use GenServer
  require Logger
  alias FinalMix.Detector.Config
  alias FinalMix.DB
  alias FinalMix.Detector.Helpers

  @name __MODULE__

  # Client methods
  def start_link(_) do
    GenServer.start_link(@name, [], name: @name)
  end

  def enqueue_attestation(attestation) do
    GenServer.cast(@name, {:enqueue_attestation, attestation})
  end

  # Server methods
  @impl true
  def init(chunk) do
    schedule_queue_processing()
    {:ok, chunk}
  end

  @impl true
  def handle_cast({:enqueue_attestation, attestation}, queue) do
    {:noreply, [attestation | queue]}
  end

  @impl true
  def handle_info(:process_queued, queue) do
    process_queued_attestations(queue)
    schedule_queue_processing()
    {:noreply, []}
  end

  defp process_queued_attestations(attestations) do
    Logger.info("Processing #{Enum.count(attestations)} attestations from queue")

    batches =
      attestations
      |> Helpers.group_by_validator_chunk_index()

    Logger.info("Updating spans for #{Enum.count(batches)} batches of grouped attestations")

    Enum.each(batches, fn {validator_chunk_idx, atts} ->
      atts_by_chunk_idx =
        atts
        |> Helpers.group_by_chunk_index()

      update_arrays(validator_chunk_idx, atts_by_chunk_idx)
    end)

    Logger.info("Finished updating arrays for #{Enum.count(batches)} batches")
  end

  defp update_arrays(validator_chunk_idx, atts_by_chunk) do
    chunks = Map.new()

    # Groups our data into triples of (chunk_idx, validator_chunk_idx, att)
    # For every attestation in our batch that contains an attesting index
    # which maps to the validator chunk index we care about
    verify_validator_chunk_idx = fn idx ->
      Config.validator_chunk_index(idx) == validator_chunk_idx
    end

    pre_process = fn {chunk_idx, atts} ->
      Enum.flat_map(atts, fn att ->
        att.attesting_indices
        |> Enum.filter(verify_validator_chunk_idx)
        |> Enum.map(&{chunk_idx, &1, att})
      end)
    end

    triples =
      atts_by_chunk
      |> Enum.flat_map(pre_process)

    # Apply the attestation for appropriate validators by updating their
    # chunks and reducing into a map containing the chunks which
    # where updated from the operation
    Enum.reduce(triples, chunks, fn {chunk_idx, validator_chunk_idx, att}, map ->
      apply_attestation_for_validator(map, chunk_idx, validator_chunk_idx, att)
    end)
  end

  defp apply_attestation_for_validator(map, validator_chunk_idx, validator_idx, att) do
  end

  defp schedule_queue_processing() do
    Process.send_after(self(), :process_queued, Config.update_interval_seconds() * 1000)
  end
end
