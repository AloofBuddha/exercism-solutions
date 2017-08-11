defmodule ProteinTranslation do
  @codon_to_protein %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    protein_list = to_protein_list rna

    if is_valid protein_list do
      {:ok, filter protein_list}
    else
      { :error, "invalid RNA" }
    end
  end

  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do 
    case Map.fetch @codon_to_protein, codon do
      {:ok, protein} -> {:ok, protein}
      :error         -> { :error, "invalid codon" }
    end
  end

  defp to_protein_list(rna) do
    rna 
    |> to_charlist
    |> Enum.chunk(3)
    |> Enum.map(&to_string/1)
    |> Enum.map(&of_codon/1)
  end

  defp is_valid(protein_list) do
    Enum.all? protein_list, fn tuple -> (elem tuple, 0) == :ok end
  end

  defp filter(protein_list) do
    protein_list
    |> Enum.map(fn tuple -> elem tuple, 1 end)
    |> Enum.take_while(fn protein -> protein != "STOP" end)
  end

end

