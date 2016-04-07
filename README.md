# Idfk / I Don't Frikkin' Know

The library of Elixir chunks of code that didn't clearly belong anywhere else.

* Developer1:  "Where should we put this chunk of code?"
* Developer2:  "I don't frikkin' know."
* Developer1:  "That's a great idea!"

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add idfk to your list of dependencies in `mix.exs`:

        def deps do
          [{:idfk, "~> 0.0.1"}]
        end

  2. Ensure idfk is started before your application:

        def application do
          [applications: [:idfk]]
        end

## Testing

Run the test suite with using espec:

        $ MIX_ENV=test mix espec

## License

This software is licensed under [the MIT license](LICENSE.md).
