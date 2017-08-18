defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """

  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> to_camel_case
    |> to_acronym
  end

  defp to_camel_case(string) do
    string
    |> String.split(~r{\s|[,-]}, trim: true)
    |> Enum.map_join(&upcase_first/1)
  end

  defp upcase_first(string) do
    {first, rest} = String.split_at(string, 1)
    (String.upcase first) <> rest
  end

  def to_acronym(string) do
    Regex.scan(~r/[A-Z]/, string)
    |> List.flatten
    |> Enum.join
  end
end
