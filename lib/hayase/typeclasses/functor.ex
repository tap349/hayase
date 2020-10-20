# https://hexdocs.pm/witchcraft/Witchcraft.Functor.html
defprotocol Hayase.Typeclasses.Functor do
  def fmap(container, f)
end

defimpl Hayase.Typeclasses.Functor, for: List do
  def fmap(list, f) when is_function(f) do
    Enum.map(list, f)
  end
end

defimpl Hayase.Typeclasses.Functor, for: Map do
  def fmap(map, f) when is_function(f) do
    map
    |> Enum.map(fn {k, v} -> {k, f.(v)} end)
    |> Enum.into(%{})
  end
end

defimpl Hayase.Typeclasses.Functor, for: Function do
  def fmap(f1, f2) do
    fn x -> f1.(f2.(x)) end
  end
end

defimpl Hayase.Typeclasses.Functor, for: Tuple do
  # ---------------------------------------------
  # Result
  # ---------------------------------------------

  def fmap({:ok, v}, f) when is_function(f) do
    Hayase.Types.Result.ok(f.(v))
  end

  def fmap({:error, _} = tuple, _), do: tuple

  # ExTwilio.Message error
  def fmap({:error, _, _} = tuple, _), do: tuple

  # Ecto.Multi error
  def fmap({:error, _, _, _} = tuple, _), do: tuple

  # ---------------------------------------------
  # Maybe
  # ---------------------------------------------

  def fmap({:just, v}, f) when is_function(f) do
    Hayase.Types.Maybe.just(f.(v))
  end
end

defimpl Hayase.Typeclasses.Functor, for: Atom do
  # ---------------------------------------------
  # Maybe
  # ---------------------------------------------

  def fmap(:nothing, _), do: :nothing
end
