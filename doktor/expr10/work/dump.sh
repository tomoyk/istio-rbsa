elasticdump \
  --input="http://elastic:elastic@192.168.201.47:9200/filebeat*" \
  --output=out.json \
  --type=data \
  --fileSize=10mb \
  --retryAttempts=2 \
  --maxSockets=5 \
  --searchBody="{\"query\": {\"range\": { \"@timestamp\": { \"gte\": \"2022-05-01T00:00:00+09:00\", \"lte\": \"2022-06-01T00:00:00+09:00\"} } }}"
