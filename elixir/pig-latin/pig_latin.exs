defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """

  @regex_vowel ~r/^([aeiou]|yt|xr)/
  @regex_consonant ~r/^(sch|squ|thr|ch|qu|th|[bcdfghjklmnpqrstvwxyz])/

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase 
    |> String.split(" ")
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  # translates an individual word to pig latin
  defp translate_word(phrase) do
    cond do
      Regex.match? @regex_vowel, phrase -> 
        phrase <> "ay"

      Regex.match? @regex_consonant, phrase ->
        {cons, rest} = split_on_consonant phrase
        rest <> cons <> "ay"
    end
  end

  defp split_on_consonant(phrase) do
    Regex.split(@regex_consonant, phrase, [include_captures: true, trim: true])
    |> List.to_tuple
  end
end

