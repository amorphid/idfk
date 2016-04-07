defmodule Idfk.DateTimeSpec do
  use ESpec

  let :posix_epoch_in_seconds, do: 62167219200

  subject do: Idfk.DateTime

  context "#to_iso8601" do
    it "returns iso8601 formatted string" do
      date   = {{2016,4,6},{16,12,35}}
      result = subject.to_iso8601(date)
      expect result |> to(eq {:ok, "2016-04-06T16:12:35+00:00"})
    end

    it "returns iso8601 formatted string w/ millisecond precision" do
      date   = {{2016,4,6},{16,12,35,123}}
      result = subject.to_iso8601(date)
      expect result |> to(eq {:ok, "2016-04-06T16:12:35.123+00:00"})
    end
  end

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
