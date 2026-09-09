# API

## 接続関係
```
Flask
 │
 │ DATABASE_URL
 ▼
SQLAlchemy
 │
 │ psycopg
 ▼
postgres:5432
 │
 ▼
PostgreSQL
```

## DATABASE_URL の解説
```yml
DATABASE_URL: postgresql+psycopg://orca:orca@postgres:5432/orca_catalog
```
| 部分 | 意味 | 今回 |
|---|---|---|
| `postgresql` | DBの種類 | PostgreSQL |
| `+psycopg` | Pythonから接続するドライバ | psycopg |
| `orca` | DBユーザー | `orca` |
| `orca` | パスワード | `orca` |
| `postgres` | 接続先ホスト | Docker Composeの `postgres` |
| `5432` | PostgreSQLのポート | `5432` |
| `orca_catalog` | データベース名 | `orca_catalog` |