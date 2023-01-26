import json
import os


from parser import parser

x = os.getenv("FILE", "out.split-0.json")
with open(x) as f:
    lines = f.read().splitlines()

buffer = []
for line in lines:
    j = json.loads(line)
    line = j["_source"]["message"]
    ns = j["_source"]["kubernetes"]["namespace"]

    if "outbound" in line:
        continue

    if "front" in ns:
        pass
    else:
        continue

    if "via_upstream" in line:
        # print(j)
        l = parser(line)
        t = l["Path"]
        buffer.append(t)
    # else:
    #     print(line)

# print(buffer)

with open(x.replace(".json", "_path.json"), mode='w') as f:
    f.write("\n".join(buffer))
