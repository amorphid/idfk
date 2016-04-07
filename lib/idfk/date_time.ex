defmodule Idfk.DateTime do
  use Timex

  @doc """
  Converts an integer formatted date_time based on the Gregorian epoch of 1 Jan 0000 @ 12:00 a.m. to an integer formatted date_time based on the posix epoch of  1 Jan 1970 @ 12:00 a.m.

      # same as this scenario
      iex> posix_epoch_in_seconds(63627199062)
      1459979862
  """
  def gregorian_to_posix(seconds) when is_integer(seconds) do
    seconds - posix_epoch_in_seconds
  end

  def gregorian_to_posix(invalid) do
    raise "Invalid arguments: #{inspect invalid}"
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
  Converts a date_time tuple with second or millisecond precision to an iso8601 formatted string within a tuple.  Assumes input is UTC.

      # second precision
      iex> to_iso8601({{2016,4,6},{16,12,35}})
      {:ok, "2016-04-06T16:12:35+00:00"}

      # millisecond precision
      iex> to_iso8601({{2016,4,6},{16,12,35,123}})
      {:ok, "2016-04-06T16:12:35.123+00:00"}
  """
  def to_iso8601({{y,mon,d},{h,min,s,mil}}) do
    case DateTime.from({{y,mon,d},{h,min,s,mil}}) do
      {:error, reason} ->
        {:error, reason}
      date_time ->
        Timex.format(date_time, "{ISO:Extended}")
    end
  end

  def to_iso8601({{y,mon,d}, {h,min,s}}) do
    to_iso8601({{y,mon,d},{h,min,s,0}})
  end

  def to_iso8601(invalid) do
    raise "Invalid arguments: #{inspect invalid}"
  end


  @doc """
  Similar to `to_iso8601`, but it returns `date_as_string` instead of `{:ok, date_as_string}`.  Raises an exception is there's an error.

      # returns a string, not a tuple
      iex> to_iso8601!({{2016,4,6},{16,12,35}})
      "2016-04-06T16:12:35+00:00"
  """
  def to_iso8601!(tuple) when is_tuple(tuple) do
    case to_iso8601(tuple) do
      {:error, reason} ->
        raise reason
      {:ok, date_time} ->
        date_time
    end
  end
end
