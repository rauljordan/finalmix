defmodule FinalMix.DB do
  use GenServer
  require Logger

  @name __MODULE__

  # Client methods
  def start_link(_) do
    {:ok, db} = CubDB.start_link(data_dir: "/tmp/finalmixdata", auto_compact: true)
    GenServer.start_link(@name, db, name: @name)
  end

  def get_max_chunk(chunk_idx, validator_idx) do
    GenServer.call(@name, {:get_max_chunk, chunk_idx, validator_idx})
  end

  # Server methods
  @impl true
  def init(db) do
    {:ok, db}
  end

  @impl true
  def handle_call({:get_max_chunk, chunk_idx, validator_idx}, _from, db) do
    chunk_hash = CubDB.get(db, "#{chunk_idx}#{validator_idx}")
    CubDB.get(db, chunk_hash)
  end
end
