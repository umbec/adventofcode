partial_overlap? = fn([r1, r2]) ->
  not Range.disjoint?(r1, r2)
end

torange = fn(s) ->
  s |> String.split("-")
    |> Enum.map(&String.to_integer/1)
    |> then(&(apply(Range, :new, &1)))
end

step1 = fn(s) ->
    s |> String.split(",")
      |> Enum.map(torange)
      |> partial_overlap?.()
      |> then(fn(x) ->
          case x do
          true -> 1
          false -> 0
          end
        end)
end

File.read!("input.txt")
|> String.trim
|> String.split("\n")
|> Enum.map(step1)
|> Enum.sum
|> IO.inspect
