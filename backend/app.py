import os

from flask import Flask, request, send_from_directory
from flask_cors import CORS
from flask_smorest import Api, Blueprint
from marshmallow import Schema, fields
import psycopg
from sqlalchemy import create_engine, select
from sqlalchemy.exc import IntegrityError
from sqlalchemy.orm import Session
from werkzeug.utils import secure_filename

from models import Base, Individual


app = Flask(__name__)

app.config["API_TITLE"] = "OrcaCatalog API" # Swaggerに表示するAPI名
app.config["API_VERSION"] = "v1"
app.config["OPENAPI_VERSION"] = "3.0.3"
app.config["OPENAPI_URL_PREFIX"] = "/"
app.config["OPENAPI_SWAGGER_UI_PATH"] = "/swagger-ui" # Swagger UI の URL
app.config["OPENAPI_SWAGGER_UI_URL"] = (
    "https://cdn.jsdelivr.net/npm/swagger-ui-dist/"
)
api = Api(app) # Flask-Smorest をアプリに登録
blp = Blueprint(
    "health",
    __name__,
    url_prefix="/api",
)

UPLOAD_DIR = os.path.join(app.root_path, "uploads")
os.makedirs(UPLOAD_DIR, exist_ok=True)
CORS(app)
# 環境変数は docker-compose.yml にて定義済
DATABASE_URL = os.environ["DATABASE_URL"]
engine = create_engine(DATABASE_URL)
Base.metadata.create_all(engine)


class HealthSchema(Schema):
    """APIの稼働状態を表すレスポンス"""
    status = fields.Str()


class DBHealthSchema(Schema):
    """データベースの接続状態を表すレスポンス"""
    database = fields.Bool()


class IndividualSchema(Schema):
    """個体情報を表すデータ"""
    id = fields.Str()
    name = fields.Str()
    description = fields.Str()
    photo_path = fields.Str(allow_none=True)


# class IndividualCreateSchema(Schema):
#     """個体登録時に受け取るデータ"""
#     id = fields.Str(required=True)
#     name = fields.Str(required=True)
#     description = fields.Str(required=True)
#     photo = fields.Raw()


# @app.get("/api/health")
@blp.get("/health")
@blp.response(200, HealthSchema)
def health():
    """APIの稼働状態を確認"""
    return {"status": "ok"}


# @app.get("/api/db-health")
@blp.get("/db-health")
@blp.response(200, DBHealthSchema)
def db_health():
    """データベースへの接続状態を確認"""
    with psycopg.connect(
        host=os.getenv("DB_HOST"),
        port=os.getenv("DB_PORT"),
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
    ) as conn:
        with conn.cursor() as cur:
            cur.execute("SELECT 1")
            result = cur.fetchone()

    return {"database": result[0] == 1}


# @app.get("/api/individuals")
@blp.get("/individuals")
@blp.response(200, IndividualSchema(many=True))
def get_individuals():
    """個体一覧を取得"""
    with Session(engine) as session:
        # SELECT * FROM individuals;
        individuals = session.scalars(
            select(Individual)
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


# @app.get("/api/individuals/<id>")
@blp.get("/individuals/<id>")
@blp.response(200, IndividualSchema)
def get_individual(id):
    """指定されたIDの個体を取得する

    Args:
        id: 取得する個体の識別番号

    Returns:
        個体情報、または個体が存在しない場合は 404
    """
    with Session(engine) as session:
        individual = session.get(Individual, id)

        if individual is None:
            return {"error": "Individual not found"}, 404

        return {
            "id": individual.id,
            "name": individual.name,
            "description": individual.description,
            "photo_path": individual.photo_path,
        }


@app.post("/api/individuals")
# @blp.post("/individuals")
# @blp.arguments(IndividualCreateSchema, location="form")
# @blp.response(201, IndividualSchema)
def create_individual():
    """写真と個体情報を登録

    201: 正常登録  
    400: 入力値またはファイル名が不正  
    409: ID が重複

    Returns:
        登録された個体情報
    """
    id = request.form.get("id")
    name = request.form.get("name")
    description = request.form.get("description")
    file = request.files.get("photo")
    # id = data["id"]
    # name = data["name"]
    # description = data["description"]
    # file = data.get("photo")

    if not id or not name or not description:
        return {
            "error": "id, name, and description are required"
        }, 400

    photo_path = None

    if file:
        filename = secure_filename(file.filename)

        if not filename:
            return {"error": "invalid filename"}, 400

        individual_dir = os.path.join(UPLOAD_DIR, id)
        os.makedirs(individual_dir, exist_ok=True)

        path = os.path.join(individual_dir, filename)
        file.save(path)

        photo_path = f"{id}/{filename}"

    individual = Individual(
        id=id,
        name=name,
        description=description,
        photo_path=photo_path,
    )

    try:
        with Session(engine) as session:
            session.add(individual)
            session.commit()

            # Sessionが生きているうちに値を取得
            result = {
                "id": individual.id,
                "name": individual.name,
                "description": individual.description,
                "photo_path": individual.photo_path,
            }

    except IntegrityError:
        return {
            "error": "Individual already exists",
            "id": id,
        }, 409

    return result, 201


@app.get("/uploads/<path:filename>")
def uploaded_file(filename):
    """アップロードされた写真を取得

    Args:
        filename: 取得する写真のパス
    """
    return send_from_directory(UPLOAD_DIR, filename)


api.register_blueprint(blp)
