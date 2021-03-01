using BenchmarkTools, LoopVectorization
#using Zygote

function weights_init(m, n)
    w = rand(m,n)
    return 2.0 * w .- 1.0
end

function sigmoid(x)
    return 1.0 ./ (1.0 .+ exp.(-x))
end

function sigmoid_s(x::T) where T <: Number
    1.0 / (1.0 + exp(-x))
end

#dsigmoid(x) = sigmoid'(x)

function sigmoid_avx(x::Matrix{Float64})
    (row, col) = size(x)
    m = Matrix{eltype(x)}(undef, row, col)
    @avx for i ∈ 1:row, j ∈ 1:col
        m[i, j] = sigmoid_s(x[i,j])
    end
    return m
end

function dsigmoid(x::Matrix{Float64})
    (row, col) = size(x)
    m = Matrix{eltype(x)}(undef, row, col)
    @avx for i in 1:row, j in 1:col
        m[i,j] = sigmoid_s(x[i,j]) * (one(eltype(x)) - sigmoid_s(x[i,j]))
    end
    return m
end

function forward(weight, inputb)
    s = inputb * weight
    return sigmoid_avx(s)
end

function add_bias(input, bias)
    b = repeat([bias], size(input, 1))
    return hcat(b, input)
end

function hide_bias(weight)
    return weight[2:end, :]
end

function train(w1, w2, input, answer, eta=0.25, times=20000)
    x = input
    v = w1
    w = w2
    t = answer
    xb = add_bias(x, -1.0)
    @inbounds for i in 2:times
        a = forward(v, xb)
        ab = add_bias(a, -1.0)
        y = forward(w, ab)
        wb = hide_bias(w)
        yt = y - t;
        dy = dsigmoid(y);
        d_o = yt .* dy;
        d_h = (d_o * wb') .* dsigmoid(a)
        
        w = w - eta * (ab' * d_o)
        v = v - eta * (xb' * d_h)
    end
    a = forward(v, xb)
    ab = add_bias(a, -1.0)
    y = forward(w, ab)
    return y
end

function main()
    v = weights_init(3,2)
    w = weights_init(3,1)
    
    x = Float64[0 0;0 1;1 0;1 1]
    t = Float64[0;1;1;0]
    
    #println("Input: ")
    #println(x)
    #println()
    #
    #println("True output: ")
    #println(t)
    #println()
    
    y = train(v, w, x, t)
    #println("Predict: ")
    #println(y)
    return y
end

#@benchmark main()

