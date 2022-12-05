full_overlap? = fn([[as, ae], [bs, be]]) ->
  (as <= bs and ae >= be) or (bs <= as and be >= ae)
end

torange = fn(s) ->
  s |> String.split("-")
    |> Enum.map(&String.to_integer/1)
end

step1 = fn(s) ->
    s |> String.split(",")
      |> Enum.map(torange)
      |> full_overlap?.()
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
