defmodule Advent1 do

    def get_floor([head|tail], currentFloor) do
        case head do
            # 40 is the code for (
            40 -> get_floor(tail, currentFloor + 1)
            # 41 is the code for )
            41 -> get_floor(tail, currentFloor - 1)
        end
    end

    def get_floor([], currentFloor) do
        currentFloor
    end

end

contents = File.read! "./data/input.txt"
IO.puts Advent1.get_floor(String.to_char_list(contents), 0)
