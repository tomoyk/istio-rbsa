h = {{a=1, b=2, c=3}, {a=4, b=5, c=6}}
h2 = {a=1, b=2, c=3}

aggre = {}

function element_counts(request_body, depth)
  local counter = 0
  for k,v in pairs(request_body) do
    if type(v) == "table" then
      print("dive")
    end
    counter = counter + 1
  end
  -- print(counter)
  table.insert(aggre, counter)
  return counter
end

r = element_counts(h2, 0)
print(r)
print(aggre)
