using BenchmarkTools, Zygote

function weights_init(m, n)
    w = rand(m,n)
    return 2 * w .- 1
end

function sigmoid(x)
    return 1.0 ./ (1.0 .+ exp.(-x))
end

dsigmoid(x) = sigmoid'(x)

function forward(weight, inputb)
    s = inputb * weight
    return sigmoid(s)
end

function add_bias(input, bias)
    b = repeat([bias], size(input, 1))
    return hcat(b, input)
end

function hide_bias(weight)
    return weight[2:end, :]
end

function train(w1, w2, input, answer, eta=0.25, times=5000)
    x = input
    v = w1
    w = w2
    t = answer
    xb = add_bias(x, -1.0)
    for i in 2:times
        a = forward(v, xb)
        ab = add_bias(a, -1.0)
        y = forward(w, ab)
        wb = hide_bias(w)
        d_o = (y - t) .* map(dsigmoid, y)
        d_h = (d_o * wb') .* map(dsigmoid, a)
        
        w = w - eta * (ab' * d_o)
        v = v - eta * (xb' * d_h)
    end
    a = forward(v, xb)
    ab = add_bias(a, -0.1)
    y = forward(w, ab)
    return y
end

function main() 
    v = weights_init(3,2)
    w = weights_init(3,1)

    x = [0 0;0 1;1 0;1 1]
    t = [0;1;1;1]

    #println("Input: ")
    #println(x)
    #println()

    #println("True output: ")
    #println(t)
    #println()

    y = train(v, w, x, t)
    #println("Predict: ")
    #println(y)
end

@benchmark main()

