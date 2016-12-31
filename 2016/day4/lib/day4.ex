defmodule Day4 do

    def get_sum_of_valid(rooms) do
        rooms
        |> Enum.map(&Regex.named_captures(~r/(?<code>.*)-(?<id>[\d]*)\[(?<checksum>[a-z]*)/, &1))
        |> Enum.map(&Map.put(&1, "calc_sum", calculate_checksum(Map.get(&1, "code"))))
        |> Enum.filter(&String.equivalent?(Map.get(&1, "calc_sum"), Map.get(&1, "checksum")))
        |> Enum.map(&Map.get(&1, "id"))
        |> Enum.map(&String.to_integer(&1))
        |> Enum.reduce(&(&1 + &2))
    end

    def calculate_checksum(code) do
      code
      |> String.replace("-", "")
      |> String.graphemes
      |> Enum.reduce(%{}, fn(x, acc) -> Map.update(acc, x, 1, &(&1 + 1)) end)
      |> (&(for {k, v} <- &1, do: {k, v})).()
      |> Enum.sort(&(sort_keys(&1, &2)))
      |> Enum.take(5)
      |> (&(for {k, _} <- &1, do: k)).()
      |> Enum.join
    end

    def sort_keys(left, right) do
      {l1, c1} = left
      {l2, c2} = right
      if c1 == c2 do
        l1 < l2
      else
        c2 < c1
      end
    end

    @doc "get the code from the file for part 1 of challenge"
    def get_code_from_file_1(path) do
         path
         |> File.read!
         |> String.split("\n")
         |> get_sum_of_valid
    end

    @doc "get the code from the file for part 2 of challenge"
    def get_code_from_file_2(path) do
         path
         |> File.read!
         |> String.split("\n")
         |> get_sum_of_valid
    end
end
