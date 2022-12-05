
parse_stack_level = fn(crates) ->
  for << <<_,v,_, _>> <- (crates <> " ") >> do
    v
  end
end

parse_stacks = fn(s) ->
  s
    |> String.split("\n")
    |> Enum.map(parse_stack_level)
    |> Enum.zip()
    |> Enum.map(&( &1 |> Tuple.to_list() |> Enum.filter(fn (x) -> not (x == ?\s) end)))
    |> Enum.reduce(%{}, fn(s, acc) -> Map.put(acc, List.last(s) - ?0, List.delete_at(s, length(s) -1)) end)
end

parse_move = fn([_move, cnt, _from, src, _to, dst]) ->
  %{
    move: String.to_integer(cnt),
    from: String.to_integer(src),
    to: String.to_integer(dst)
  }
end

parse_moves = fn(s) ->
  s
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&(String.split(&1, " ")))
    |> Enum.map(parse_move)
end

parse = fn([stacks, moves]) ->
  s = parse_stacks.(stacks)
  m = parse_moves.(moves)
  %{stacks: s, moves: m}
end

move = fn(%{move: count, from: from, to: to }, s) ->
  fs = Map.get(s, from)
  ts = Map.get(s, to)
  {moved, fs} = Enum.split(fs, count)
  s
    |> Map.put(from, fs)
    |> Map.put(to, Enum.reverse(moved) ++ ts)
end

play = fn(%{stacks: s, moves: m}) ->
  Enum.reduce(m, s, move)
end

solve = fn(s) ->
  Enum.map(s, fn({k, [top| _]}) -> top end)
end

File.read!("input.txt")
|> String.split("\n\n")
|> then(parse)
|> then(play)
|> then(solve)
|> IO.inspect
