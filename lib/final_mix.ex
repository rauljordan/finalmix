defmodule FinalMix do
  use GenServer

  # alias MyApp.ClassifierImpl

  # @name __MODULE__

  def start_link(_) do
    {:ok, channel} = GRPC.Stub.connect("localhost:4000")
    GenServer.start_link(@name, channel, name: @name)
  end

  def init(channel) do
    IO.puts("Starting channel to gRPC Server")
    {:ok, channel}
  end
end
