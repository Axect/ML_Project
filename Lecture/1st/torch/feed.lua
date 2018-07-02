require("torch");

--[[
Prepare Training Set
--]]

X = torch.rand(10,1)
Y = torch.Tensor(10,1)

for i = 1,10 do
    if X[i][1] > 0.5 then
        Y[i][1] = 1
    else
        Y[i][1] = 0
    end
end

require("nn");

inputs = 1
outputs = 1

model = nn.Sequential()
model:add(nn.Linear(inputs, outputs))
model:add(nn.Sigmoid())

print(model:get(1).weight) -- Random Weight
print(model:get(1).bias) -- Random Bias

-- First Epoch
print(X[1])

model:forward(X[1])

print(Y[1])

h_x = model:forward(X)
for i = 1,10 do
  print("h_x = ", h_x[i][1], " Y = ", Y[i][1])
end

-- Loss Function
loss = nn.MSECriterion()
optimState = {learningRate = 0.15}

-- Repeat
maxIteration = 100

for epoch = 1,maxIteration do
  model:get(1).gradWeight:zero()
  model:get(1).gradBias:zero()
  h_x = model:forward(X)
  J = loss:forward(h_x, Y)
  print(string.format("Current Loss: %.4f", J))
  dJ_dh_x = loss:backward(h_x, Y)
  model:backward(X, dJ_dh_x)
  model:updateParameters(optimState.learningRate)
end

h_x = model:forward(X)
for i = 1,10 do
  print("h_x = ", h_x[i][1], " Y = ", Y[i][1])
end

test = torch.rand(10, 1)
answer = torch.Tensor(10, 1)

for i = 1,10 do
  if test[i][1] > 0.5 then
    answer[i][1] = 1
  else
    answer[i][1] = 0
  end
end

print(model:forward(test)); print(answer)
