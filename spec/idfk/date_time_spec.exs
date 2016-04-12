defmodule Idfk.DateTimeSpec do
  use ESpec

  let :posix_epoch_in_seconds, do: 62167219200

  subject do: Idfk.DateTime

  before do: allow Idfk.DateTime |> to(accept :datetime,
                                    fn -> {{2016, 4, 12}, {19, 11, 51}} end)
  before do: allow Idfk.DateTime |> to(accept :timestamp,
                                    fn -> {1460, 488396, 730374} end)
  context "#datetime_with_milliseconds" do
    it "returns a tuple of integers" do
      result = subject.datetime_with_milliseconds
      expect result |> to(eq {{2016, 4, 12}, {19, 11, 51, 730}})
    end
  end

  context "#gregorian_seconds_to_posix_seconds" do
    it "returns integer" do
      gregorian = posix_epoch_in_seconds + 10
      result    = subject.gregorian_seconds_to_posix_seconds(gregorian)
      expect result |> to(eq 10)
    end

    it "raise error w/ invalid input" do
      result    = fn -> subject.gregorian_seconds_to_posix_seconds("lol not an integer") end
      expect result |> to(raise_exception)
    end
  end

  context "#posix_epoch_in_seconds" do
    it "equals 62167219200" do
      result = subject.posix_epoch_in_seconds
      expect result |> to(eq posix_epoch_in_seconds)
    end
  end

  context "#to_iso8601" do
    it "returns {:ok, string} w/ second precision" do
      date   = {{2016,4,6},{16,12,35}}
      result = subject.to_iso8601(date)
      expect result |> to(eq {:ok, "2016-04-06T16:12:35+00:00"})
    end

    it "returns {:ok, string} w/ millisecond precision" do
      date   = {{2016,4,6},{16,12,35,123}}
      result = subject.to_iso8601(date)
      expect result |> to(eq {:ok, "2016-04-06T16:12:35.123+00:00"})
    end

    it "returns {:error, :invalid_datetime} w/ non integer values" do
      date   = {{2016,4,6},{16,12,35,"lol not an integer"}}
      result = subject.to_iso8601(date)
      expect result |> to(eq {:error, :invalid_datetime})
    end
  end

  context "#to_iso8601!" do
    it "returns string" do
      date   = {{2016,4,6},{16,12,35,123}}
      result = subject.to_iso8601!(date)
      expect result |> to(eq "2016-04-06T16:12:35.123+00:00")
    end

    it "raise error w/ invalid input" do
      date   = {{2016,4,6},{16,12,35,"lol not an integer"}}
      result = fn -> subject.to_iso8601!(date) end
      expect result |> to(raise_exception)
    end
  end
end
