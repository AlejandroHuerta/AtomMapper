# AtomMapper

A library for taking a string map and converting it into an atom map by following a spec

## Installation

The package can be installed as:

  1. Add `atom_mapper` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:atom_mapper, "~> 0.1.0"}]
    end
    ```

## Use
  ```user_sent = %{"this": "is", "some": "data", "that": %{"was": 0, "sent": true}}
  #create a spec for the above data to comply to
  spec = %{this: [:is], some: :any, that: %{was: &AtomMapper.is_any/1, sent: &is_integer/1}}
  AtomMapper.map(user_sent, spec)
  #=> %{this: :is, some: "data", that: %{was: 0}}
  ```
