decode = fn(c) ->
    case c do
	"A" -> :r
	"B" -> :p
	"C" -> :s
	"X" -> :l
	"Y" -> :d
	"Z" -> :w
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
    [x, :d] -> [worth.(x), points.(:d)]
    [:r, x = :w] -> [worth.(:p), points.(x)]
    [:r, x = :l] -> [worth.(:s), points.(x)]
    [:s, x = :w] -> [worth.(:r), points.(x)]
    [:s, x = :l] -> [worth.(:p), points.(x)]
    [:p, x = :w] -> [worth.(:s), points.(x)]
    [:p, x = :l] -> [worth.(:r), points.(x)]
    end
    end


File.read!("input.txt")
|> String.trim
|> String.split("\n")
|> Enum.map(play)
|> List.flatten
|> Enum.sum
|> IO.inspect
