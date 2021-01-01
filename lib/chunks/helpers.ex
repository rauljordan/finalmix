defmodule FinalMix.Chunks.Helpers do
  alias FinalMix.Detector.Config

  def get_chunk_target(chunk, validator_idx, epoch, target_epoch) do
    # TODO: Verify lengths
    validator_offset = Config.validator_offset(validator_idx)
    chunk_offset = Config.chunk_offset(epoch)
    cell_idx = Config.cell_index(validator_offset, chunk_offset)
     # TODO: Return distance at index + epoch
    chunk
  end

  def set_chunk_target(chunk, validator_idx, epoch, target_epoch) do
    distance = epoch_distance(epoch, target_epoch)
    set_raw_distance(chunk, validator_idx, epoch, distance)
  end

  def set_raw_distance(chunk, validator_idx, epoch, target_distance) do
    validator_offset = Config.validator_offset(validator_idx)
    chunk_offset = Config.chunk_offset(epoch)
    cell_idx = Config.cell_index(validator_offset, chunk_offset)
    if cell_idx < Enum.count(chunk) do
      # chunk[cellIdx] = targetDistance
    end
    chunk
  end

  def epoch_distance(epoch, base_epoch) do
    # TODO: Underflow checks
    epoch - base_epoch
  end
end
