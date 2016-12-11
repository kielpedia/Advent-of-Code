defmodule Day1 do

    @directions %{:north => %{"L" => :west, "R" => :east},
        :east => %{"L" => :north, "R" => :south},
        :south => %{"L" => :east, "R" => :west},
        :west => %{"L" => :south, "R" => :north}}

    def get_block_distance(moves, location \\ {0, 0}, cardinal \\ :north)
    def get_block_distance([], {x, y}, _) do abs(x) + abs(y) end
    def get_block_distance([head | tail], location, cardinal) do
        {direction, distance} = String.split_at(head, 1)
        new_cardinal = get_in(@directions, [cardinal, direction])
        {distance, _} = Integer.parse(distance)

        new_pos = get_new_location(new_cardinal, location, distance)

        get_block_distance(tail, new_pos, new_cardinal)
    end

    defp get_new_location(:north, {x, y}, distance) do {x, y + distance} end
    defp get_new_location(:east, {x, y}, distance) do {x + distance, y} end
    defp get_new_location(:south, {x, y}, distance) do {x, y - distance} end
    defp get_new_location(:west, {x, y}, distance) do {x - distance, y} end

    def get_distance_from_file(path) do
     path
     |> File.read!
     |> String.split(", ")
     |> get_block_distance
    end
end
