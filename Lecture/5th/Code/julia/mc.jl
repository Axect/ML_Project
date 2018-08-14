a = rand(1000000)
pspi = mapreduce(x -> 4 / (1 + x^2), +, a) / 1000000
println(pspi)
