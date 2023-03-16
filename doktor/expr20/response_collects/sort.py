import json

with open("fulltext-Wi-Fi.txt") as f:
    j = json.load(f)

k = j["fulltexts"]
m = sorted(k, key=lambda x: x['page_number'])
j["fulltexts"] = m

print(json.dumps(m, indent=4))
with open("fulltext-Wi-Fi2.txt", mode='w') as f2:
    json.dump(m, f2)
