find result_* -type f | xargs wc -c > RESULT_SUMMARY.txt
      21 result_bson/bson.fulltext-Kubernetes.result
      21 result_bson/bson.fulltext-recall.result
   47065 result_bson/bson.fulltext-Wi-Fi.result
   44179 result_bson/bson.fulltext-iot.result
      21 result_bson/bson.fulltext-Sigfox.result
      12 result_jsonbinpack/bin.fulltext-Kubernetes.result
      86 result_jsonbinpack/_encoding.json
      12 result_jsonbinpack/bin.fulltext-recall.result
      12 result_jsonbinpack/bin.fulltext-Sigfox.result
   23323 result_jsonbinpack/bin.fulltext-Wi-Fi.result
   21912 result_jsonbinpack/bin.fulltext-iot.result
       2 result_rbsi/rbsi.fulltext-recall.result
       2 result_rbsi/rbsi.fulltext-Kubernetes.result
      10 result_rbsi/rbsi.fulltext-Wi-Fi.result
       2 result_rbsi/rbsi.fulltext-Sigfox.result
      10 result_rbsi/rbsi.fulltext-iot.result
  136690 total


cat RESULT_SUMMARY.txt | grep ".result$"| awk '{gsub("result[^/]+/", "", $0);print $1"\t"$2}' > RESULT_SUMMARY2.txt
21	bson.fulltext-Kubernetes.result
21	bson.fulltext-recall.result
47065	bson.fulltext-Wi-Fi.result
44179	bson.fulltext-iot.result
21	bson.fulltext-Sigfox.result
12	bin.fulltext-Kubernetes.result
12	bin.fulltext-recall.result
12	bin.fulltext-Sigfox.result
23323	bin.fulltext-Wi-Fi.result
21912	bin.fulltext-iot.result
2	rbsi.fulltext-recall.result
2	rbsi.fulltext-Kubernetes.result
10	rbsi.fulltext-Wi-Fi.result
2	rbsi.fulltext-Sigfox.result
10	rbsi.fulltext-iot.result

