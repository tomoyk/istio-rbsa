# 実験2

この実験では提案手法の表現力を検証する．

同一のJSONに障害シナリオを設定し，RBSAで判別できるのか表現力を評価する．

- 正常なケース
- 異常なケース
    - 順序の異常（参考文献）
    - 件数の減少や増加（参考文献）

## やること

- 正常なケースを3つ用意する．
- 正常なケースから異常なケースを用意する．
- ケースの管理はMarkdownかスプレッドシート，ファイル分割したtxt？

## メモ jsonbinpack

```
# Encoding file create
./node_modules/.bin/jsonbinpack compile fulltext-openapi.json > _encoding.json

# Binpacked file create
./node_modules/.bin/jsonbinpack serialize _encoding.json response_collects/fulltext-Wi-Fi.txt > _output.bin

# Binpacked file unpack
./node_modules/.bin/jsonbinpack deserialize _encoding.json _output.bin
```
