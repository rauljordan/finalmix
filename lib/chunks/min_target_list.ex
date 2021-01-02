defmodule FinalMix.MinTargetList do
  @moduledoc """
  A list of min targets for slashing detection
  """
  defstruct [:items]

  @typedoc """
  A list of uint16 min distances
  """
  @type t() :: list(number())
end

defimpl FinalMix.TargetListChunk, for: FinalMix.MinTargetList do
  alias FinalMix.Detector.Config
  alias FinalMix.Chunks.Helpers
  def neutral_element(_list) do
    65535 # MaxUint16
  end

  def update(list, current_epoch) do
    min_epoch = current_epoch - (Config.history_size() - 1)
    update_target(list, chunk_idx, validator_idx, min_epoch, new_target_epoch, current_epoch)
  end

  defp update_target(chunk, chunk_idx, validator_idx, min_epoch, new_target_epoch, epoch) do
    if Config.chunk_index(epoch) != chunk_idx || epoch < min_epoch do
      epoch >= min_epoch
    end
    chunk_target = Helpers.get_chunk_target(chunk, validator_idx, epoch)
    if new_target_epoch < chunk_target do
      chunk = Helpers.set_chunk_target(chunk, validator_idx, epoch, new_target_epoch)
      update_target(chunk, chunk_idx, validator_idx, min_epoch, new_target_epoch, epoch-1)
    end
    false
  end

  def first_start_epoch(_list, source_epoch, current_epoch) do
    difference = current_epoch - Config.history_size()
    if source_epoch > difference do
      source_epoch - 1
    else
      0
    end
  end

  def next_start_epoch(_list, start_epoch) do
    Integer.floor_div(start_epoch, Config.chunk_size())*Config.chunk_size() - 1
  end
end
