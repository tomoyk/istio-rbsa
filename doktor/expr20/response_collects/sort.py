import json

basename = "fulltext-Wi-Fi.txt"
newname = basename.replace(".txt", "2.txt")

with open(basename) as f:
    j = json.load(f)

k = j["fulltexts"]
m = sorted(k, key=lambda x: x['page_number'])
j["fulltexts"] = m

print(json.dumps(m, indent=4, ensure_ascii=False))
with open(newname, mode='w') as f2:
    json.dump(m, f2, ensure_ascii=False)
