# OrcaCatalog

シャチの個体識別・写真カタログサービスのプロトタイプを作成する

## 目的

一般ユーザーがシャチの個体を検索・閲覧し、写真と個体情報を登録できるWeb/iOSアプリのプロトタイプ

現段階では実際の要件は未確定であり、先方との打ち合わせに向けた技術検証・叩き台として作成する

そのため、過剰な機能や複雑なアーキテクチャは導入しない

## 技術構成

- Web: Next.js
- iOS: SwiftUI
- API: Python + Flask
- ORM: SQLAlchemy
- Database: PostgreSQL
- Local development: Docker Compose
- API形式: REST
- Web/iOSから同一APIを利用する
- iOSはXcodeから実行するためDockerには含めない

## リポジトリ構成

```text
OrcaCatalog/
├── apps/
│   ├── nextjs/
│   └── swiftui/
├── backend/
├── docs/
├── compose.yaml
└── README.md
```

## プロトタイプの機能

### 個体一覧

- 個体の一覧を表示
- 写真、名前、説明を表示
- 検索・フィルタリングができる

### 個体詳細

- 個体の写真を表示
- 名前を表示
- 説明を表示

### 個体登録

- 個体ID
- 名前
- 説明
- 写真

を入力して登録できる

### 写真

プロトタイプでは個体ごとに1枚の写真を扱う

写真はAPI経由でアップロードする

開発環境ではFlask側のuploadsディレクトリに保存する

## Backend

SQLAlchemyで以下のモデルを作成する

```python
Individual:
    id
    name
    description
    photo_path
```

API:

```text
GET  /api/health
GET  /api/db-health
GET  /api/individuals
GET  /api/individuals/<id>
POST /api/individuals
GET  /uploads/<path:filename>
```

POST `/api/individuals` はmultipart/form-dataを受け取り、

- id
- name
- description
- photo

を処理する

画像ファイル名は安全な形式に変換し、個体IDごとのディレクトリに保存する

例:

```text
uploads/
└── K-001/
    └── photo.jpg
```

APIレスポンスには相対パスとして

```text
K-001/photo.jpg
```

を返す

## Web

Next.jsで以下の画面を作成する

- Home
- Individual Detail
- Register

Home:

- 個体一覧
- 検索
- 個体カード
- 個体詳細への遷移

Detail:

- 写真
- 個体名
- 説明
- 一覧へ戻る

Register:

- 個体ID
- 名前
- 説明
- 写真選択
- 登録

登録成功後はHomeへ戻る

## iOS

SwiftUIで以下を作成する

- Home
- Individual Detail
- Register

TabViewを使用し、

```text
Home | Register
```

の構成にする

HomeではAPIから個体一覧を取得する

RegisterではPhotosPickerを使用して写真を選択し、multipart/form-dataでAPIへ送信する

iOSのAPI接続先は設定値として分離する

## 設計方針

- 過剰なDDDやClean Architectureは導入しない
- 必要以上にクラスを増やさない
- 小さなプロトタイプとして理解しやすい構成を優先する
- 将来変更できる程度の分離は行う
- フレームワークの機能を素直に利用する
- 独自の抽象化を作る前に標準機能を検討する

## ドキュメント

PythonコードにはSphinx autodocで利用できるdocstringを記述する

SphinxはFuroテーマを使用する

ドキュメントは以下から構成する

```text
docs/
├── conf.py
├── index.rst
└── api.rst
```

`docs/index.rst` をドキュメントの入口とする

## 開発方針

一度に全機能を実装せず、以下の順番で進める

1. リポジトリとDocker Compose
2. PostgreSQL
3. Flask API
4. Next.js
5. SwiftUI
6. Sphinx
7. テスト
8. 必要に応じてクラウドへのデプロイ

各段階で実行確認してから次へ進む

コードを変更した場合は、変更理由と確認方法を簡潔に説明する

複雑な設計を追加する場合は、実装前に理由を説明する
