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
      |> Helpers.group_by_validator_index()

    Logger.info("Updating spans for #{Enum.count(batches)} batches of grouped attestations")

    Enum.each batches, fn {_, atts} ->
      atts_by_chunk_idx =
        atts
        |> Helpers.group_by_chunk_index()
      update_arrays(atts_by_chunk_idx)
    end
    Logger.info("Finished updating arrays for #{Enum.count(batches)} batches")
  end

  defp update_arrays(atts_by_chunk_idx) do
    updated_chunks = Map.new()
    Enum.reduce atts_by_chunk_idx, updated_chunks, fn ({_chunk_idx, _atts}, acc) ->
      acc
    end
  end

  defp schedule_queue_processing() do
    # Every 5 seconds
    Process.send_after(self(), :process_queued, Config.update_interval_seconds() * 1000)
  end
end
