defmodule Advent2 do

    def get_total({l, w, h}, currentTotal) do
        l = elem(Integer.parse(l), 0)
        w = elem(Integer.parse(w), 0)
        h = elem(Integer.parse(h), 0)
        currentTotal + get_square_foot({l, w, h})
    end

    def get_square_foot({l,w,h}) do
        {lw, wh, lh} = {l*w, w*h, l*h}

        2*lw + 2*wh + 2*lh + get_smallest(Enum.sort(Tuple.to_list({lw, wh, lh})))
    end

    def get_smallest([head | tail]) do
        head
    end

end

stream = File.stream! "./data/input.txt"
results = Enum.scan(stream, 0, fn row, total ->
    row = String.replace(row, "\n", "")
    [l,w,h] = String.split(row, "x");
    Advent2.get_total({l,w,h}, total)
    end)

IO.puts List.last(results)
