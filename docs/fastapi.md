# FastAPI
- [SwaggerUI](http://localhost:5001/docs)

- get_individual(id) の swaggerUI
| HTTP | 今回の意味 |
|---|---|
| 200 | 個体が取得できた |
| 404 | `id` に該当する個体がDBに存在しない |
| 422 | FastAPIがリクエストパラメータの検証に失敗した |

- SQLAlchemy の lazy loading と Session の寿命の問題
```
Sessionが開いている間
    ↓
Observationを取得
    ↓
Sessionを閉じる
    ↓
PydanticがObservationResponseへ変換
    ↓
individualを読もうとする
    ↓
「individualをDBから取りに行かなきゃ」
    ↓
でもSessionはもう閉じている
    ↓
DetachedInstanceError
```
```
select(Observation)
        │
        └─ selectinload(Observation.individual)
                    ↓
              individualも取得
                    ↓
              Session内でロード済み
                    ↓
              Session終了
                    ↓
              Pydanticが変換
```
