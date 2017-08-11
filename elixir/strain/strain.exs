defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def keep(list, fun), do: iterate(list, fun, [])

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  # @spec discard(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def discard(list, fun), do: iterate(list, &(!fun.(&1)), [])

  # @spec iterate(list :: list(any), fun :: ((any) -> boolean)), acc :: list(any) :: list(any)
  defp iterate([], _fun, acc), do: Enum.reverse acc

  defp iterate([ head | tail], fun, acc) do
    new_acc = if fun.(head), do: [head | acc], else: acc
    iterate(tail, fun, new_acc)
  end
end
