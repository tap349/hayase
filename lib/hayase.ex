defmodule Hayase do
  defmacro __using__(_opts) do
    quote do
      alias Hayase.Typeclasses.Functor
      alias Hayase.Typeclasses.Monad
      alias Hayase.Types.{Maybe, Result}
    end
  end
end
