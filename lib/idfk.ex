defmodule Idfk do
  @doc """
  Raises an error for any argument deemed invalid.

      # You might use it in a module like this:
      defmodule AtomEater do
        # atoms are valid
        def eat(atom) when is_atom(atom) do
          IO.puts "Mmm, that \#{atom} was excellent!"
        end

        # anything other than atoms raises an exception
        def eat(invalid) do
          Idfk.raise_invalid_arg!(invalid)
        end
      end

  Basic usage:

      iex> Idfk.raise_invalid_arg! "lol invalid"
      ** (RuntimeError) Invalid argument: "lol invalid"
  """
  def raise_invalid_arg!(invalid) do
    raise "Invalid argument: #{inspect invalid}"
  end
end
