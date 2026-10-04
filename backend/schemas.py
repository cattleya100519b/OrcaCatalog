"""FastAPI 用 Pydantic モデル"""

from pydantic import BaseModel, ConfigDict


class HealthResponse(BaseModel):
    """APIの稼働状態を表すレスポンス"""
    status: str


class DBHealthResponse(BaseModel):
    """データベースの接続状態を表すレスポンス"""
    database: bool


class IndividualResponse(BaseModel):
    """個体情報を表すレスポンス"""
    model_config = ConfigDict(from_attributes=True)

    id: str
    name: str
    description: str
    photo_path: str | None


class ObservationResponse(BaseModel):
    """観察情報を表すレスポンス"""
    model_config = ConfigDict(from_attributes=True)

    id: str
    latitude: float
    longitude: float
    individual: IndividualResponse