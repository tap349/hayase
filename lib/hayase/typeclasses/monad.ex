# https://hexdocs.pm/witchcraft/Witchcraft.Chain.html
defprotocol Hayase.Typeclasses.Monad do
  def bind(monad, f)
  def tap(monad, f)
end

# > https://hexdocs.pm/witchcraft/Witchcraft.Chain.html#chain/2
# >
# > The chain function essentially "unwraps" a contained value, applies a
# > linking function that returns the initial (wrapped) type, and collects
# > them into a flat(ter) structure.
# >
# > chain/2 is sometimes called "flat map", since it can also be expressed
# > as `data |> map(link_fun) |> flatten()`.
defimpl Hayase.Typeclasses.Monad, for: List do
  def bind(list, f) when is_function(f) do
    Enum.flat_map(list, f)
  end

  def tap(list, f) when is_function(f) do
    Enum.each(list, &f.(&1))
    list
  end
end

defimpl Hayase.Typeclasses.Monad, for: Tuple do
  # -------------------------------------------------------
  # Result
  # -------------------------------------------------------

  def bind({:ok, v}, f) when is_function(f), do: f.(v)
  def bind({:error, _} = tuple, _), do: tuple

  # ExTwilio.Message error
  def bind({:error, _, _} = tuple, _), do: tuple

  # Ecto.Multi error
  def bind({:error, _, _, _} = tuple, _), do: tuple

  # -------------------------------------------------------
  # Maybe
  # -------------------------------------------------------

  def bind({:just, v}, f) when is_function(f), do: f.(v)

  # -------------------------------------------------------
  # Result
  # -------------------------------------------------------

  def tap({:ok, v} = tuple, f) when is_function(f) do
    f.(v)
    tuple
  end

  # -------------------------------------------------------
  # Maybe
  # -------------------------------------------------------

  def tap({:error, _} = tuple, _), do: tuple

  # ExTwilio.Message error
  def tap({:error, _, _} = tuple, _), do: tuple

  # Ecto.Multi error
  def tap({:error, _, _, _} = tuple, _), do: tuple

  # -------------------------------------------------------
  # Maybe
  # -------------------------------------------------------

  def tap({:just, v} = tuple, f) when is_function(f) do
    f.(v)
    tuple
  end
end

defimpl Hayase.Typeclasses.Monad, for: Atom do
  # -------------------------------------------------------
  # Maybe
  # -------------------------------------------------------

  def bind(:nothing, _), do: :nothing
  def tap(:nothing, _), do: :nothing
end
