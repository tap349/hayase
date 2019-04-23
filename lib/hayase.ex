defmodule Hayase do
  defmacro __using__(_opts) do
    quote do
      import Hayase.Typeclasses.Functor
      import Hayase.Typeclasses.Monad

      alias Hayase.Types.{Maybe, Result}
    end
  end
end
