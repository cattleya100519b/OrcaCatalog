"""データベース接続設定"""

import os

from sqlalchemy import create_engine


# 環境変数は docker-compose.yml にて定義済
DATABASE_URL = os.environ["DATABASE_URL"]

engine = create_engine(DATABASE_URL)
