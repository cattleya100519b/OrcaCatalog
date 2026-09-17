from sqlalchemy import String, ForeignKey
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column


class Base(DeclarativeBase):
    """これから定義するDBテーブルの親になるクラス"""
    pass


class Individual(Base):
    """個体情報を表すDBテーブル

    Attributes:
        id: 個体を識別するID
        name: 個体名
        description: 個体の説明
        photo_path: 個体写真の保存先
    """
    # PostgreSQLではこの名前のテーブルにする
    # デフォルトのスキーマを使う (public という名前空間)
    __tablename__ = "individuals"

    # id: Mapped[str] は Python 側の型、mapped_column(...) が DB 側のカラム定義
    id: Mapped[str] = mapped_column(String(50), primary_key=True)
    name: Mapped[str] = mapped_column(String(100))
    description: Mapped[str] = mapped_column(String(500))
    photo_path: Mapped[str | None] = mapped_column(String(500), nullable=True)


class Observation(Base):
    """観察情報を表すDBテーブル

    Attributes:
        id: 観察情報を識別する ID
        individual_id: 観察された個体の ID（への参照）
        latitude: 観察地点の緯度
        longitude: 観察地点の経度
    """
    __tablename__ = "observations"

    id: Mapped[str] = mapped_column(String(50), primary_key=True)
    individual_id: Mapped[str] = mapped_column(
        ForeignKey("individuals.id")
    )
    latitude: Mapped[float]
    longitude: Mapped[float]