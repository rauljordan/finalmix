defmodule FinalMix.MaxTargetList do
  @moduledoc """
  A list of max targets for slashing detection
  """
  defstruct [:items]

  @typedoc """
  A list of uint16 max distances
  """
  @type t() :: list(number())
end

defimpl FinalMix.TargetListChunk, for: FinalMix.MaxTargetList do
  def neutral_element(_list) do
    0
  end

  def update(_list) do
    false
  end

  def first_start_epoch(_list, _source_epoch, _current_epoch) do
    0
  end

  def next_start_epoch(_list, _start_epoch) do
    0
  end
end
