defprotocol FinalMix.TargetListChunk do
  @doc "Returns the neutral element of the type of target list"
  @spec neutral_element(t) :: number()
  def neutral_element(t)

  @doc """
  Updates a target list chunk and returns a boolean we can use
  to determine if we should continue updating the next possible chunk
  """
  @spec update(t) :: boolean()
  def update(t)

  @doc """
  Returns the first start epoch of a target list chunk given
  a source epoch and current epoch
  """
  @spec first_start_epoch(t, number(), number()) :: number()
  def first_start_epoch(t, source_epoch, current_epoch)

  @doc """
  Returns the start epoch of the next target list chunk
  given a start epoch of the current chunk
  """
  @spec next_start_epoch(t, number()) :: number()
  def next_start_epoch(t, start_epoch)
end
