defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text 
    |> to_charlist
    |> Enum.map(fn ascii -> shifter(ascii, shift) end)
    |> to_string
  end

  @spec shifter(ascii :: integer, shift :: integer) :: integer
  defp shifter(ascii, shift) do
    shifted = ascii + shift
    cond do
      # uppercase
      ascii in 65..90 ->
        if shifted <= 90, do: shifted, else: 65 + rem(shifted, 90) - 1
      # lowercase
      ascii in 97..122 ->
        if shifted <= 122, do: shifted, else: 97 + rem(shifted, 122) - 1
      # non-alphabetic
      true ->
        ascii
    end
  end
end

