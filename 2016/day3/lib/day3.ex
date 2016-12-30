defmodule Day3 do

    def get_valid_triangle_count(triangles) do
        triangles
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
        |> Enum.map(&String.split(&1))
        |> get_valid_triangle_count
    end

    @doc "get the code from the file for part 2 of challenge"
    def solve_with_file_part_2(path) do
        path
        |> File.read!
        |> String.split("\n")
        |> group_triangles_by_column
        |> get_valid_triangle_count
    end

    defp group_triangles_by_column(lines, triangles \\ [])
    defp group_triangles_by_column([one | [two | [three | tail]]], triangles) do
        triangles = triangles ++ zip([String.split(one), String.split(two), String.split(three)])
        group_triangles_by_column(tail, triangles)
    end
    defp group_triangles_by_column(_, triangles) do triangles end

    # zip all enumerables - needed until Elixir 1.4
    defp zip([head | []]) do Enum.map(head, &List.flatten(&1)) end
    defp zip([head | [head2 | tail]]) do
      zip([head |> Enum.zip(head2) |> Enum.map(&Tuple.to_list(&1)) | tail])
    end

end
