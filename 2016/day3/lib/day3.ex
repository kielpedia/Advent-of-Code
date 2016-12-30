defmodule Day3 do

    def get_valid_triangle_count(triangles) do
        triangles
        |> Enum.map(&String.split(&1))
        |> Enum.map(&is_valid?(&1))
        |> Enum.filter(&(&1))
        |> Enum.count
    end

    defp is_valid?(sides) do
      [s1, s2, s3] = sides |> Enum.map(&String.to_integer(&1))
      s1 + s2 > s3 && s2 + s3 > s1 && s3 + s1 > s2
    end

    @doc "get the valid count from the file for part 1 of challenge"
    def solve_with_file_part_1(path) do
        path
        |> File.read!
        |> String.split("\n")
        |> get_valid_triangle_count
    end

#    @doc "get the code from the file for part 2 of challenge"
#    def solve_with_file_part_2(path) do
#        path
#        |> File.read!
#        |> String.split("\n")
##        |> get_code_from_key(@keypad2)
#    end
end
