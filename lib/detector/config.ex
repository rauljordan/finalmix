defmodule FinalMix.Config do
  @chunk_size 16
  @validator_chunk_size 256
  @history_length 4096

  def chunk_index(epoch) do
    epoch
    |> Kernel.rem(@history_length)
    |> Integer.floor_div(@chunk_size)
  end

  def validator_chunk_index(validator_index) do
    validator_index
    |> Integer.floor_div(@chunk_size)
  end

  def chunk_offset(epoch) do
    Kernel.rem(epoch, @chunk_size)
  end

  def validator_offset(validator_index) do
    Kernel.rem(validator_index, @validator_chunk_size)
  end

  def cell_index(validator_offset, chunk_offset) do
    validator_offset * @chunk_size + chunk_offset
  end
end
