# https://hexdocs.pm/algae/Algae.Either.html
defmodule Hayase.Types.Result do
  def wrap({:ok, _} = result), do: result
  def wrap({:error, _} = result), do: result
  def wrap(nil), do: error()
  def wrap(:error), do: error()
  def wrap(v), do: ok(v)

  def unwrap({:ok, v}), do: v
  def unwrap({:error, v}), do: v
  def unwrap(v), do: v

  def ok(v), do: {:ok, v}
  def error, do: {:error, nil}
  def error(v), do: {:error, v}
end
