defmodule Idfk.DateTime do
  use Timex

  @doc """
  Converts an integer formatted date_time based on the Gregorian epoch of 1 Jan 0000 @ 12:00 a.m., and you need an integer formatted date_time based on the posix epoch of  1 Jan 1970 @ 12:00 a.m.

      # same as this scenario
      iex> posix_epoch_in_seconds(63627199062)
      1459979862
  """
  def gregorian_to_posix(seconds) when is_integer(seconds) do
    seconds - posix_epoch_in_seconds
  end

  @doc """
  The datetime 1 Jan 1970 @ 12:00 a.m. in seconds.  Hard coded for performance reasons.

      # same as this scenario
      iex> :calendar.datetime_to_gregorian_seconds({{1970,1,1},{0,0,0}})
      62167219200
  """
  def posix_epoch_in_seconds do
    62167219200
  end

  @doc """
  Converts a date_time tuple with millisecond precision to an iso8601 formatted string within a tuple.  Assumes input is UTC.

      # Example
      iex> to_iso8601({{2016,4,6},{16,12,35,123}})
      {:ok, "2016-04-06T16:12:35.123+00:00"}
  """
  def to_iso8601({{y,mon,d},{h,min,s,mil}}) do
    DateTime.from({{y,mon,d},{h,min,s,mil}})
    |> Timex.format("{ISO:Extended}")
  end

  @doc """
  Converts a date_time tuple with second precision to an iso8601 formatted string within a tuple.  Assumes input is UTC.

      # Example
      iex> to_iso8601({{2016,4,6},{16,12,35}})
      {:ok, "2016-04-06T16:12:35+00:00"}
  """
  def to_iso8601({{y,mon,d}, {h,min,s}}) do
    to_iso8601({{y,mon,d},{h,min,s,0}})
  end
end
