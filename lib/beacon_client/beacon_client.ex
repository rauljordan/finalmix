defmodule FinalMix.BeaconClient do
  use GenServer
  require Logger

  @name __MODULE__

  # Client methods
  def start_link(_) do
    {:ok, channel} =
      GRPC.Stub.connect("localhost:4000",
        adapter_opts: %{
          http2_opts: %{keepalive: 10000}
        }
      )

    Logger.metadata(endpoint: "localhost:4000")
    Logger.info("Starting gRPC connection to beacon node")
    GenServer.start_link(@name, channel, name: @name)
  end

  # Server methods
  @impl true
  def init(channel) do
    GenServer.cast(@name, {:stream_indexed_attestations})
    {:ok, channel}
  end

  @impl true
  def handle_cast({:stream_indexed_attestations}, channel) do
    req = Google.Protobuf.Empty.new()

    case channel |> Ethereum.Eth.V1alpha1.BeaconChain.Stub.stream_indexed_attestations(req) do
      {:ok, stream} ->
        Enum.each(stream, fn {:ok, indexed_att} ->
          FinalMix.Detector.enqueue_attestation(indexed_att)
        end)

      {:error, err} ->
        IO.inspect(err)
    end

    {:noreply, channel}
  end
end
