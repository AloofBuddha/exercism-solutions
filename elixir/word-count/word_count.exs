defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence 
    |> tokenize 
    |> normalize
    |> to_count_map

  end

  defp tokenize(sentence) do
    String.split(sentence, ~r/[\s,_!&@$%^&:]/, trim: true) 
  end

  defp normalize(words) do
    Enum.map(words, &String.downcase/1)
  end

  defp to_count_map(words) do
    Enum.reduce(words, %{}, fn(x, acc) -> 
      Map.update acc, x, 1, &(&1 + 1) 
    end)
  end
end
