defmodule IdfkSpec do
  use ESpec

  subject do: Idfk

  context "#raise_invalid_arg!" do
    it "raise exception with message" do
      arg    = "lol an exception"
      result = fn -> subject.raise_invalid_arg!(arg) end
      expect result |> to(raise_exception RuntimeError,
                          "Invalid argument: #{inspect arg}")
    end
  end
end
