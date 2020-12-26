defmodule FinalMix.Detector do
  use GenServer
  require Logger
  alias FinalMix.Detector.Config
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

    Enum.each batches, fn {_, atts} ->
      atts_by_chunk_idx =
        atts
        |> Helpers.group_by_chunk_index
      update_arrays(atts_by_chunk_idx)
    end

    Logger.info("Finished updating arrays for #{Enum.count(batches)} batches")
  end

  defp update_arrays(atts_by_chunk) do
    chunks = Map.new()
    Enum.reduce atts_by_chunk, chunks, fn ({chunk_idx, atts}, map) ->
      Enum.reduce atts, map, fn (att, acc) ->
        att.attesting_indices
        |> Enum.filter(fn idx -> idx == Config.validator_chunk_index(idx) end)
        |> Enum.reduce(acc, fn (validator_idx, acc2) ->
          apply_attestation_for_validator(acc2, chunk_idx, validator_idx, att)
        end)
      end
    end
  end

  def apply_attestation_for_validator(map, validator_chunk_idx, validator_idx, att) do
    map
  end

  defp schedule_queue_processing() do
    # Every 5 seconds
    Process.send_after(self(), :process_queued, Config.update_interval_seconds() * 1000)
  end
end
