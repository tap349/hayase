defmodule Hayase do
  defmacro __using__(_opts) do
    quote do
      alias Hayase.Typeclasses.Functor, as: F
      alias Hayase.Typeclasses.Monad, as: M
      alias Hayase.Types.{Maybe, Result}
    end
  end
end
