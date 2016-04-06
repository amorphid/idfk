defmodule Idfk.DateTimeSpec do
  use ESpec

  subject do: Idfk.DateTime

  context "#posix_epoch_in_seconds" do
    it "equals 62167219200" do
      result = subject.posix_epoch_in_seconds
      expect result |> to(eq 62167219200)
    end
  end
end
