defmodule Idfk.DateTime do
  use Timex

  @type datetime :: datetime_second_precision | datetime_millis_precision
  @type datetime_millis_precision :: {{year, month, day}, {hours, minutes, seconds, milliseconds}}
  @type datetime_second_precision :: {{year, month, day}, {hours, minutes, seconds}}
  @type day :: integer
  @type hours :: integer
  @type megaseconds :: integer
  @type microseconds :: integer
  @type milliseconds :: integer
  @type minutes :: integer
  @type month :: integer
  @type seconds :: integer
  @type timestamp :: {megaseconds, seconds, microseconds}
  @type year :: integer

  @doc """
  Returns the datetime with milliseconds.  Even though method has arity of 2, arguments are only used for testing purposes.

      # Normally you'll simply call without arguments
      Idfk.DateTime.datetime_with_milliseconds
  """
  @spec datetime_with_milliseconds(datetime_second_precision, timestamp) :: datetime_millis_precision
  def datetime_with_milliseconds(datetime  \\ :calendar.universal_time,
                                 timestamp \\ :os.timestamp) do
    {{y,mon,d},{h,min,s}} = datetime
    {_,_,mic} = timestamp
    mil = div(mic, 1000)
    {{y,mon,d},{h,min,s,mil}}
  end

  @doc """
  Converts an integer formatted datetime based on the Gregorian epoch of 1 Jan 0000 @ 12:00 a.m. to an integer formatted datetime based on the posix epoch of  1 Jan 1970 @ 12:00 a.m.

      iex> Idfk.posix_epoch_in_seconds(63627199062)
      1459979862
  """
  @spec gregorian_seconds_to_posix_seconds(integer) :: integer
  def gregorian_seconds_to_posix_seconds(seconds)

  def gregorian_seconds_to_posix_seconds(seconds) when is_integer(seconds) do
    seconds - posix_epoch_in_seconds
  end

  def gregorian_seconds_to_posix_seconds(invalid) do
    Idkf.raise_invalid_arg!(invalid)
  end

  @doc """
  The datetime 1 Jan 1970 @ 12:00 a.m. in seconds.  Hard coded for performance reasons.

      # same as this scenario
      iex> :calendar.datetime_to_gregorian_seconds({{1970,1,1},{0,0,0}})
      62167219200
  """
  @spec posix_epoch_in_seconds :: integer
  def posix_epoch_in_seconds do
    62167219200
  end

  @doc """
  Converts a datetime tuple with second or millisecond precision to an iso8601 formatted string within a tuple.  Assumes input is UTC.

      # second precision
      iex> Idfk.to_iso8601({{2016,4,6},{16,12,35}})
      {:ok, "2016-04-06T16:12:35+00:00"}

      # millisecond precision
      iex> Idfk.to_iso8601({{2016,4,6},{16,12,35,123}})
      {:ok, "2016-04-06T16:12:35.123+00:00"}
  """
  def to_iso8601(datetime)

  @spec to_iso8601({{year, month, day}, {hours, minutes, seconds, milliseconds}}) :: {:ok, String.t} | {:error, term}
  def to_iso8601({{y,mon,d},{h,min,s,mil}}) do
    case DateTime.from({{y,mon,d},{h,min,s,mil}}) do
      {:error, reason} ->
        {:error, reason}
      datetime ->
        Timex.format(datetime, "{ISO:Extended}")
    end
  end

  @spec to_iso8601({{year, month, day}, {hours, minutes, seconds}}) :: {:ok, String.t} | {:error, term}
  def to_iso8601({{y,mon,d}, {h,min,s}}) do
    to_iso8601({{y,mon,d},{h,min,s,0}})
  end

  def to_iso8601(invalid) do
    Idkf.raise_invalid_arg!(invalid)
  end


  @doc """
  Similar to `to_iso8601`, but it returns `date_as_string` instead of `{:ok, date_as_string}`.  Raises an exception is there's an error.

      iex> Idfk.to_iso8601!({{2016,4,6},{16,12,35}})
      "2016-04-06T16:12:35+00:00"
  """
  @spec to_iso8601!(datetime) :: String.t
  def to_iso8601!(datetime) when is_tuple(datetime) do
    case to_iso8601(datetime) do
      {:error, reason} ->
        raise reason
      {:ok, datetime} ->
        datetime
    end
  end
end
