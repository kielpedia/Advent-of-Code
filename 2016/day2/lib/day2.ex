defmodule Day2 do

    @keypad1 %{
              0 => %{0 => "1", 1 => "2", 2 => "3"},
              1 => %{0 => "4", 1 => "5", 2 => "6"},
              2 => %{0 => "7", 1 => "8", 2 => "9"}
            }

    @keypad2 %{
              0 => %{2 => "1"},
              1 => %{1 => "2", 2 => "3", 3 => "4"},
              2 => %{0 => "5", 1 => "6", 2 => "7", 3 => "8", 4 => "9"},
              3 => %{1 => "A", 2 => "B", 3 => "C"},
              4 => %{2 => "D"}
    }

    def get_code_from_key(lines, keypad) do
        lines
        |> Enum.scan({0, 2}, &get_coordinates(&1, &2, keypad))
        |> Enum.map(&get_digit_from_coordinate(&1, keypad))
        |> Enum.join
    end

    defp get_coordinates(moves, start, keypad) do
        moves
        |> String.graphemes
        |> Enum.reduce(start, &move(&1, &2, keypad))
    end

    defp move(dir, {x,y}, keypad) do
      {x2, y2} = get_next_coords(dir, {x, y})

      if is_nil(get_in(keypad, [x2, y2])) do
        {x, y}
      else
        {x2, y2}
      end
    end

    defp get_next_coords("U", {x, y}) do {x, y - 1} end
    defp get_next_coords("L", {x, y}) do {x - 1, y} end
    defp get_next_coords("R", {x, y}) do {x + 1, y} end
    defp get_next_coords("D", {x, y}) do {x, y + 1} end

    defp get_digit_from_coordinate({x, y}, keypad) do
      get_in(keypad, [y, x])
    end

    @doc "get the code from the file for part 1 of challenge"
    def get_code_from_file_1(path) do
         path
         |> File.read!
         |> String.split("\n")
         |> get_code_from_key(@keypad1)
    end

    @doc "get the code from the file for part 2 of challenge"
    def get_code_from_file_2(path) do
         path
         |> File.read!
         |> String.split("\n")
         |> get_code_from_key(@keypad2)
    end
end
