defmodule Idfk.DateTime do
  @doc """
  The date 1 Jan 1970 @ 12:00 a.m. in seconds.  Hard coded for performance reasons.

    # same as running this command
    iex> :calendar.datetime_to_gregorian_seconds({{1970,1,1},{0,0,0}})
    62167219200
  """
  def posix_epoch_in_seconds do
    62167219200
  end
end
