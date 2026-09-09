from sqlalchemy import String
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column


class Base(DeclarativeBase):
    """これから定義するDBテーブルの親になるクラス"""
    pass


class Individual(Base):
    """"""
    # PostgreSQLではこの名前のテーブルにする
    # デフォルトのスキーマを使う (public という名前空間)
    __tablename__ = "individuals"

    # id: Mapped[str] は Python 側の型、mapped_column(...) が DB 側のカラム定義
    id: Mapped[str] = mapped_column(String(50), primary_key=True)
    name: Mapped[str] = mapped_column(String(100))
    description: Mapped[str] = mapped_column(String(500))
    photo_path: Mapped[str | None] = mapped_column(String(500), nullable=True)
    