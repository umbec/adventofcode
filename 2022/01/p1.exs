File.read!("input.txt") |> String.trim() |> String.split("\n\n") |> Enum.map(fn x -> String.split(x,"\n") |> Enum.map(&String.to_integer/1) |> Enum.sum() end) |> Enum.max |> IO.puts
