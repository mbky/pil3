--[[
Use coroutines to transform the function in Exercise 5.4 into a generator for combinations, to be used like here:

for c in combinations({"a", "b", "c"}, 2) do
  printResult(c)
end
]]

function rest(list)
  return (function(head, ...) return table.pack(...) end)(unpack(list))
end

function combination_generator(a, m)
  local tail = rest(a)
  local result = {}

  if m > #a then
    return
  end

  if m == 0 then
    coroutine.yield({{}})
    return
  end

  for v in combinations(tail, m - 1) do
    table.insert(v, 1, a[1])
    coroutine.yield(v)
  end

  for v in combinations(tail, m) do
    coroutine.yield(v)
  end
end

function combinations(a, m)
  local co = coroutine.create(function() combination_generator(a, m) end)

  return function()
    local code, res = coroutine.resume(co)
    return res
  end
end

function printResult(a)
  for i = 1, #a do
    if type(a[i]) == 'string' then
      io.write(a[i], ' ')
    end
  end

  io.write('\n')
end

for c in combinations({'a', 'b', 'c'}, 2) do
  printResult(c)
end

--[[
a b
a c
c b
]]
