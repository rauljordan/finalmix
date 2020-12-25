defmodule FinalMix.Supervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    children = [
      {FinalMix.DB, name: FinalMix.DB},
      {FinalMix.BeaconClient, name: FinalMix.BeaconClient},
      {FinalMix.Chunker, name: FinalMix.Chunker}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
