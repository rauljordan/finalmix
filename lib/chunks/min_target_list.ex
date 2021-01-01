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
  def neutral_element(_list) do
    65535 # MaxUint16
  end

  def update(_list) do
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
