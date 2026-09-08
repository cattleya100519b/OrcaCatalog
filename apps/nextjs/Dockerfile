FROM node:26

# Dockerコンテナの中で /app を作って、そこを作業ディレクトリにする
WORKDIR /app

# Mac側にある package.json と package-lock.json をDockerの /app にコピー
COPY package*.json ./
# DockerのLinux環境の中で、改めて依存パッケージをインストール
RUN npm ci

# Next.jsプロジェクトの残り全部をDockerの /app にコピー
# イメージを作るためには必要だが、開発時にはマウント (docker-compose.yml の volumes) によって上書きされる
COPY . .

# このコンテナの中では3000番ポートを使う
# docker-compose.yml の ports 設定で繋がる
EXPOSE 3000

# Next.js 開発モード起動
CMD ["npm", "run", "dev"]