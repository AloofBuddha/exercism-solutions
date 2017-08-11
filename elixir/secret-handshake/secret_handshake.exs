defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  import Bitwise, only: [&&&: 2]

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do    
    [] 
    |> commands_add(code, 0b00001, "wink")
    |> commands_add(code, 0b00010, "double blink")
    |> commands_add(code, 0b00100, "close your eyes")
    |> commands_add(code, 0b01000, "jump")
    |> commands_reverse(code, 0b10000)
  end

  defp commands_add(acc, code, bin, phrase) do
    if (code &&& bin) != 0 do
      acc ++ [phrase]
    else
      acc
    end
  end

  defp commands_reverse(acc, code, bin) do
    if (code &&& bin) != 0 do
      Enum.reverse acc
    else
      acc
    end
  end
end

