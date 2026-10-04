"""FastAPI 版"""
import os

from fastapi import FastAPI, File, Form, HTTPException, UploadFile
from fastapi.responses import FileResponse
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy import text, select
from sqlalchemy.orm import Session, selectinload
from sqlalchemy.exc import IntegrityError
from werkzeug.utils import secure_filename

from schemas import (
    HealthResponse,
    DBHealthResponse,
    IndividualResponse,
    ObservationResponse,
)
from database import engine
from models import Base, Individual, Observation


# 画像保存先
UPLOAD_DIR = os.path.join(
    os.path.dirname(__file__),
    "uploads",
)
os.makedirs(UPLOAD_DIR, exist_ok=True)

app = FastAPI()

# CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

Base.metadata.create_all(engine)


@app.get("/api/health", response_model=HealthResponse)
def health():
    """APIの稼働状態を確認"""
    return {"status": "ok"}


@app.get("/api/db-health", response_model=DBHealthResponse)
def db_health():
    """データベースへの接続状態を確認"""
    with engine.connect() as conn:
        result = conn.execute(text("SELECT 1")).scalar()

    return {"database": result == 1}


@app.get(
    "/api/individuals",
    response_model=list[IndividualResponse],
)
def get_individuals():
    """個体一覧を取得"""
    with Session(engine) as session:
        individuals = session.scalars(
            select(Individual)
            .order_by(Individual.created_at.desc())
        ).all()

    return [
        {
            "id": individual.id,
            "name": individual.name,
            "description": individual.description,
            "photo_path": individual.photo_path,
        }
        for individual in individuals
    ]


@app.get(
    "/api/individuals/{id}",
    response_model=IndividualResponse,
)
def get_individual(id: str):
    """指定されたIDの個体を取得する

    Args:
        id: 取得する個体の識別番号

    Returns:
        個体情報、または個体が存在しない場合は 404
    """
    with Session(engine) as session:
        individual = session.get(Individual, id)

        if individual is None:
            raise HTTPException(
                status_code=404,
                detail="Individual not found",
            )

        return {
            "id": individual.id,
            "name": individual.name,
            "description": individual.description,
            "photo_path": individual.photo_path,
        }


@app.get(
    "/api/observations",
    response_model=list[ObservationResponse],
)
def get_observations():
    """観察情報一覧を取得"""
    with Session(engine) as session:
        observations = session.scalars(
            select(Observation).options(
                # eager loading
                # Observation を取得するときに、関連する Individual も予め取得しておく
                selectinload(Observation.individual)
            )
        ).all()

    return observations


@app.post(
    "/api/individuals",
    response_model=IndividualResponse,
    status_code=201,
)
def create_individual(
    id: str = Form(),
    name: str = Form(),
    description: str = Form(),
    latitude: float = Form(),
    longitude: float = Form(),
    photo: UploadFile | None = File(None),
):
    """写真と個体情報を登録"""
    # 写真保存
    photo_path = None

    if photo:
        filename = secure_filename(photo.filename)

        if not filename:
            raise HTTPException(
                status_code=400,
                detail="invalid filename",
            )

        individual_dir = os.path.join(
            UPLOAD_DIR,
            id,
        )
        os.makedirs(individual_dir, exist_ok=True)

        path = os.path.join(
            individual_dir,
            filename,
        )

        with open(path, "wb") as f:
            f.write(photo.file.read())

        photo_path = f"{id}/{filename}"

    individual = Individual(
        id=id,
        name=name,
        description=description,
        photo_path=photo_path,
    )

    observation = Observation(
        id=id,
        individual_id=id,
        latitude=latitude,
        longitude=longitude,
    )

    # DB 登録
    try:
        with Session(engine) as session:
            session.add(individual)
            session.add(observation)
            session.commit()

            result = IndividualResponse.model_validate(individual)

    # 重複 ID → 409
    except IntegrityError:
        raise HTTPException(
            status_code=409,
            detail={
                "error": "Individual already exists",
                "id": id,
            },
        )

    return result


@app.get("/uploads/{filename:path}")
def uploaded_file(filename: str):
    """アップロードされた写真を取得

    Args:
        filename: 取得する写真のパス
    """
    path = os.path.join(UPLOAD_DIR, filename)

    if not os.path.isfile(path):
        raise HTTPException(
            status_code=404,
            detail="File not found",
        )

    return FileResponse(path)