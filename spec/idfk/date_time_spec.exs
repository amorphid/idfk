defmodule Idfk.DateTimeSpec do
  use ESpec

  let :posix_epoch_in_seconds, do: 62167219200

  subject do: Idfk.DateTime

  context "#gregorian_to_posix" do
    it "returns an integer" do
      gregorian = posix_epoch_in_seconds + 10
      result    = subject.gregorian_to_posix(gregorian)
      expect result |> to(eq 10)
    end

    it "raise error w/ float input" do
      gregorian = posix_epoch_in_seconds + 10.12345
      result    = fn -> subject.gregorian_to_posix(gregorian) end
      expect result |> to(raise_exception)
    end
  end

  context "#posix_epoch_in_seconds" do
    it "equals 62167219200" do
      result = subject.posix_epoch_in_seconds
      expect result |> to(eq posix_epoch_in_seconds)
    end
  end
end
