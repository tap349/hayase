# https://wiki.haskell.org/Maybe
# https://stackoverflow.com/a/18809252/3632318
defmodule Hayase.Types.Maybe do
  def wrap({:just, _} = maybe), do: maybe
  def wrap(:nothing = maybe), do: maybe
  def wrap(nil), do: nothing()
  def wrap(v), do: just(v)

  def unwrap({:just, v}), do: v
  def unwrap(:nothing), do: nil
  def unwrap(v), do: v
  def unwrap({:just, v}, _fallback), do: v
  def unwrap(:nothing, fallback), do: fallback

  def just(v), do: {:just, v}
  def nothing, do: :nothing
end
