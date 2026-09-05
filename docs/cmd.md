# コマンド集

## common
- ディレクトリツリー表示
```sh
tree -d
# nextjs 自動生成除外
tree -d -I 'node_modules|.next'
```

- ディレクトリ作成
```sh
# [id] はNext.jsの動的ルートで、/individuals/K-001 のようなURLを受け取れる
mkdir -p app/individuals/[id]
```

## Next.js
- 新規プロジェクト作成 (name=nextjs)
```sh
# npx: npmパッケージとして公開されているコマンドを実行
# create-next-app: Next.js公式のプロジェクト生成ツール
# nextjs: 生成先のディレクトリ名
npx create-next-app@latest nextjs
```

- Next.js 開発モード起動
```sh
# package.json に定義されている next dev を実行
# サーバ停止は ctrl(^)+c
npm run dev
```


## ReactNative
- 新規プロジェクト作成 (name=nextjs)
```sh
npx create-expo-app@latest reactnative
```

- 事前設定
```sh
# Macが使用するXcodeの開発者ツールを /Applications/Xcode.app のモノに設定
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
# Xcodeの初回起動時に必要な開発環境のセットアップをコマンドラインから実行
xcodebuild -runFirstLaunch
# Xcodeに含まれるiOS Simulatorの管理ツール simctl を使って、利用可能なシミュレータの一覧を表示
xcrun simctl list
```

- ReactNative 起動
```sh
# 先に Simulator を立ち上げておけば、任意の iPhone で起動できる
npm run ios
```

- ローカルビルド
```sh
npx expo run:ios --device
```

- 追加パッケージ
```sh
# 写真アップロード？
npx expo install expo-image-picker
```

- 動作確認
```sh
# expo start
npm start
# npm start
#    ↓
# Metro Bundlerを起動
#    ↓
# JS/TSコードをiPhoneに配信

# npx expo run:ios
#    ↓
# iOSアプリを再ビルド
#    ↓
# ExponentImagePickerをアプリに組み込む
```

## Flutter
- 新規作成
```sh
flutter create --project-name orca_catalog_flutter flutter
```

- BUILD
```sh
flutter run
flutter devices
flutter run -d "iPhone Air"
flutter config --enable-web # ❌safari
flutter run -d Chrome
```
