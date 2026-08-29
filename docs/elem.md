1. フロントエンド
- Next.js
- React
- TypeScript
- CSS / Tailwind CSS あたり
- フォーム処理
- 画像表示・ギャラリー
- API通信（fetch など）
```
・画面
個体一覧
個体詳細
写真一覧
写真詳細
写真アップロード
投稿情報入力
```

2. バックエンド / API
- Python
- Flask
- REST API
- JSON
- HTTP
- CORS
- バリデーション
```
GET    /api/individuals
GET    /api/individuals/{id}
GET    /api/photos
GET    /api/photos/{id}
POST   /api/photos
POST   /api/observations
GET    /api/observations
```

3. データベース
- PostgreSQL
- PostGIS
- GISデータ
- 緯度経度
- 空間検索
```
Individual
    id
    name
    description

Photo
    id
    path
    captured_at
    location

Observation
    id
    individual_id
    photo_id
    observed_at
    location
```

4. 画像・ファイル
- S3
- Cloud Storage
- Azure Blob Storage
```
DB
  └── photo_id
       path / URL
```
```
Object Storage
  └── photos/
       ├── xxx.jpg
       ├── yyy.jpg
       └── ...
```

5. 認証・ユーザ
- ユーザ登録
- ログイン
- セッション / JWT
- 権限
- 投稿者情報

6. 画像処理
- Pillow
- OpenCV
- NumPy
- EXIF
- 画像リサイズ
- サムネイル生成
- メタデータ抽出
```
original.jpg
     │
     ├── thumbnail.jpg
     └── metadata
          ├── 撮影日時
          └── GPS
```

7. 画像認識 / ML
- PyTorch
- torchvision
- OpenCV
- NumPy
- 学習済みモデル
- 個体識別モデル
-  embedding / 類似画像検索
```
画像
 ↓
シャチ検出
 ↓
個体識別
 ↓
候補個体
 ↓
人間が確認
```

8. 地理情報
- 緯度・経度
- GeoJSON
- PostGIS
- 地図表示
- MapLibre / Mapbox / Leaflet
```
写真
 ├── 個体
 ├── 撮影日時
 └── 撮影場所
          ↓
       地図上に表示
```

9. 生態学的データモデル
```
Individual
Observation
Photo
Location
Group
Behavior
Researcher
Contributor
```
```
写真
 ↓
観察記録
 ↓
個体
 ↓
場所・日時・群れ・行動
```

10. MLOps

| ツール | 何をするもの |
|---|---|
| **MLflow** | 「このモデルはどのデータ・パラメータで作った？」を記録、モデル管理 |
| **Kubeflow** | MLの処理パイプラインを組んで実行・管理 |
| **Airflow** | 「毎日3時にこの処理を実行」みたいなワークフロー管理 |
| **SageMaker** | AWSがML開発・学習・デプロイ周辺をまとめて提供 |
| **Vertex AI** | Google Cloud版の総合ML基盤 |
| **Docker** | ML専用ではないが、学習・推論環境を固める |
| **GitHub Actions等** | テストやデプロイを自動化 |
