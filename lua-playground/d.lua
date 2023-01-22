h = {{a=1, b=2, c=3}, {a=4, b=5, c=6}}
h2 = {a=1, b=2, c=3}

aggre = {}

function element_counts(request_body, depth)
  local counter = 0
  for k,v in pairs(request_body) do
    if type(v) == "table" then
      print("dive")
      element_counts(v, depth+1)
    else
      counter = counter + 1
    end
  end
  -- print(counter)
  aggre[depth] = counter
end

element_counts(h, 1)

for k,v in pairs(aggre) do
  print("depth=", k, "counts=", v)
end
