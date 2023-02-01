n1 = "logs-2023-01-27-05-44-46-n/raw-length1-average"
e1 = "logs-2023-01-28-03-23-22-e/raw-length1-average"
# p1 = "logs-2023-01-27-05-25-12-p/raw-length1-average"

with open(e1) as fe:
    e = fe.read().splitlines()
with open(n1) as fp:
    p = fp.read().splitlines()


diff_e = {}
diff_p = {}
for x in e:
     k = " ".join(x.split("\t")[0:2])
     v = x.split("\t")[2]
     diff_e[k] = v
for x in p:
     print(x)
     k = " ".join(x.split("\t")[0:2])
     v = x.split("\t")[2]
     diff_p[k] = v

# 804, 71
# print(len(diff_e), len(diff_p))

for x in diff_p.keys():
    try:
        print(x + "\t" + str(float(diff_p[x]) - float(diff_e[x])))
    except Exception:
        continue
