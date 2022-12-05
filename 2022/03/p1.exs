
char2point = fn(<<c>>) ->
    case c do
      c when c <= ?Z ->
        c - ?A + 27
      c when c <= ?z ->
        c - ?a + 1
    end
end

grind = fn(s) ->
    s |> String.codepoints()
      |> Enum.map(char2point)
      |> MapSet.new()
end

step1 = fn(s) ->
    l = String.length(s)
    sl = String.slice(s, 0..(div(l, 2)) - 1)
        |> grind.()
    sr = String.slice(s, div(l, 2)..l)
        |> grind.()
    MapSet.intersection(sr, sl)
        |> MapSet.to_list
end

File.read!("input.txt")
|> String.trim
|> String.split("\n")
|> Enum.map(step1)
|> List.flatten
|> Enum.sum
|> IO.inspect
