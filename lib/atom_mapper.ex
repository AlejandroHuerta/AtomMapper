defmodule AtomMapper.AtomMapper do

  def is_any(value), do: value

  def map(map, spec = %{}) do
    Enum.reduce Map.to_list(spec), %{}, fn tuple = {atom, _}, acc ->
      case Map.fetch(map, Atom.to_string(atom)) do
        {:ok, v} ->
          key(acc, v, tuple)
        :error -> acc
      end
    end
  end

  defp key(acc, value, {atom, :any}), do: Map.put(acc, atom, value)

  defp key(acc, value, {atom, atoms}) when is_list(atoms) do
    key(acc, value, {atom, &Enum.find(atoms, false, fn a -> Atom.to_string(a) == &1 end)})
  end

  defp key(acc, value, {atom, map}) when is_map(map) do
    Map.put(acc, atom, map(value, map))
  end

  defp key(acc, value, {atom, fun}) do
    case fun.(value) do
      true -> Map.put(acc, atom, value)
      false -> acc
      v -> Map.put(acc, atom, v)
    end
  end
end