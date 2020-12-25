defmodule FinalMix.Detector do
  use GenServer
  require Logger

  @name __MODULE__

  # Client methods
  def start_link(_) do
    GenServer.start_link(@name, [], name: @name)
  end

  def process_attestation(attestation) do
    GenServer.cast(@name, {:process_attestation, attestation})
  end

  # Server methods
  @impl true
  def init(chunk) do
    schedule_queue_processing()
    {:ok, chunk}
  end

  @impl true
  def handle_cast({:process_attestation, attestation}, queue) do
    Logger.info("Processing attestation")
    {:noreply, [attestation | queue]}
  end

  @impl true
  def handle_info(:process_queued, queue) do
    IO.puts(queue.size())
    # Reschedule once more
    schedule_queue_processing()
    {:noreply, queue}
  end

  defp schedule_queue_processing() do
    # Every 5 seconds
    Process.send_after(self(), :process_queued, 5000)
  end
end
