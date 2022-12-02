decode = fn(c) ->
    case c do
	"A" -> :r
	"B" -> :p
	"C" -> :s
	"X" -> :r
	"Y" -> :p
	"Z" -> :s
    end
    end

worth = fn(x) ->
    case x do
    :r -> 1
    :p -> 2
    :s -> 3
    end
    end

points = fn(r) ->
    case r do
    :w -> 6
    :d -> 3
    :l -> 0
    end
    end

play = fn(s) ->
    game = String.split(s, " ") |> Enum.map(decode)
    case game do
    [x, x] -> [worth.(x), points.(:d)]
    [:r, x = :p] -> [worth.(x), points.(:w)]
    [:r, x = :s] -> [worth.(x), points.(:l)]
    [:s, x = :r] -> [worth.(x), points.(:w)]
    [:s, x = :p] -> [worth.(x), points.(:l)]
    [:p, x = :s] -> [worth.(x), points.(:w)]
    [:p, x = :r] -> [worth.(x), points.(:l)]
    end
    end


File.read!("input.txt")
|> String.trim
|> String.split("\n")
|> Enum.map(play)
|> List.flatten
|> Enum.sum
|> IO.inspect
