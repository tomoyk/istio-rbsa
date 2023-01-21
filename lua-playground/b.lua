h = {{a=1, b=2, c=3}, {a=4, b=5, c=6}}
print(h)
for k1, v1 in pairs(h) do
  -- print(k1, v1)
  for k2, v2 in pairs(v1) do
    print(k2, v2)
  end
end
