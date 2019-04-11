# Hayase

Simple implementation of common ADTs (`Maybe`, `Result`) and their instances
of `Functor` and `Monad` typeclasses in Elixir.

This package is based on [towel](https://github.com/knrz/towel) package but
modifies and extends it in a few ways:

- add `Hayase.Maybe.unwrap/2` to provide fallback value (just like
  `Algae.Maybe.from_maybe/2` from `algae` package)
- `unwrap` functions from both `Maybe` and `Result` ADTs don't unwrap
  passed values recursively but do it one level deep only
- return value of `Hayase.Functor.fmap/2` is always constructed with
  the same type constructor as input value
- implement an instance of `Functor` typeclass for Elixir maps

`hayase` package is not meant to replace other packages providing algebraic
and categorical abstractions - it aims to implement a small subset of their
functionality which seems to be enough for my needs.

## Examples

using `Hayase.Types.Maybe` - before processing it's useful to wrap input value
with `Hayase.Types.Maybe.wrap/1` so that `Maybe` value is built automatically:

```elixir
use Hayase

# -----------------------------------------------
# using with `Hayase.Typeclasses.Functor.fmap/2`
# -----------------------------------------------

"foo"
|> Maybe.wrap()
|> fmap(fn x -> x <> " bar" end)
|> fmap(fn x -> x <> " baz" end)
# => {:just, "foo bar baz"}

nil
|> Maybe.wrap()
|> fmap(fn x -> x <> " bar" end)
|> fmap(fn x -> x <> " baz" end)
# => :nothing

# -----------------------------------------------
# using with `Hayase.Typeclasses.Monad.bind/2`
# -----------------------------------------------

"foo"
|> Maybe.wrap()
|> bind(fn x -> x <> Maybe.just(" bar") end)
|> bind(fn x -> x <> Maybe.just(" baz") end)
# => {:just, "foo bar baz"}

"foo"
|> Maybe.wrap()
|> bind(fn x -> x <> Maybe.just(" bar") end)
|> bind(fn x -> x <> Maybe.nothing(" baz") end)
# => :nothing

nil
|> Maybe.wrap()
|> bind(fn x -> x <> Maybe.just(" bar") end)
|> bind(fn x -> x <> Maybe.just(" baz") end)
# => :nothing

# -----------------------------------------------
# unwrapping
# -----------------------------------------------

{:just, "foo bar baz"}
|> Maybe.unwrap()
# => "foo bar baz"

:nothing
|> Maybe.unwrap()
# => nil

:nothing
|> Maybe.unwrap("fallback value")
# => "fallback value"
```

using `Hayase.Types.Result` - as a rule it's not necessary to wrap input value
with `Hayase.Types.Result.wrap/1` since in most cases it's provided already as
a `Result` value (that is tagged tuple):

```elixir
use Hayase

# -----------------------------------------------
# using with `Hayase.Typeclasses.Functor.fmap/2`
# -----------------------------------------------

{:ok, "foo"}
|> fmap(fn x -> x <> " bar" end)
|> fmap(fn x -> x <> " baz" end)
# => {:ok, "foo bar baz"}

{:error, "error"}
|> fmap(fn x -> x <> " bar" end)
|> fmap(fn x -> x <> " baz" end)
# => {:error, "error"}

# -----------------------------------------------
# using with `Hayase.Typeclasses.Monad.bind/2`
# -----------------------------------------------

{:ok, "foo"}
|> bind(fn x -> x <> Result.ok(" bar") end)
|> bind(fn x -> x <> Result.ok(" baz") end)
# => {:ok, "foo bar baz"}

{:ok, "foo"}
|> bind(fn x -> x <> Result.error("error") end)
|> bind(fn x -> x <> Result.ok(" baz") end)
# => {:error, "error"}

# -----------------------------------------------
# unwrapping
# -----------------------------------------------

{:ok, "foo bar baz"}
|> Result.unwrap()
# => "foo bar baz"

{:error, "error"}
|> Result.unwrap()
# => "error"
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `hayase` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:hayase, "~> 0.1"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/hayase](https://hexdocs.pm/hayase).

## TODO

- tests
- docs