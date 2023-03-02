# about

このディレクトリは，以下の検証実験に関するファイルが配置されている．

This directory includes program files for following experiments.

- HTTPレスポンスの応答時間 / HTTP response time 
- ログメッセージのメッセージ長さ（サイズ） / Log message length (unit: bytes)

実験で変更した条件は以下である．

The changed conditions in the exepriments are below.
All logging types are based on Istio default log formats.
Additional values are added into end of the log formats.

- 提案手法(RBSA / proposed logging)
- HTTPレスポンスBodyをすべて書き出し(reponse body full logging)
- なし(default loggiing)

負荷試験はdoktorのプロダクションから収集したログを使っている．

Load tests utilizes production logs which are collected from Doktor.
