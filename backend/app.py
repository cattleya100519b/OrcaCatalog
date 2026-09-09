import os

from flask import Flask, request, send_from_directory
from flask_cors import CORS
import psycopg
from sqlalchemy import create_engine, select
from sqlalchemy.exc import IntegrityError
from sqlalchemy.orm import Session
from werkzeug.utils import secure_filename

from models import Base, Individual


app = Flask(__name__)
UPLOAD_DIR = os.path.join(app.root_path, "uploads")
os.makedirs(UPLOAD_DIR, exist_ok=True)
CORS(app)
# 環境変数は docker-compose.yml にて定義済
DATABASE_URL = os.environ["DATABASE_URL"]
engine = create_engine(DATABASE_URL)
Base.metadata.create_all(engine)


@app.get("/api/health")
def health():
    return {"status": "ok"}


@app.get("/api/db-health")
def db_health():
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


@app.get("/api/individuals")
def get_individuals():
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


@app.get("/api/individuals/<id>")
def get_individual(id):
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
    

# @app.post("/api/individuals")
# def create_individual():
#     """POST
    
#     201: 正常登録
#     400: 入力がおかしい
#     409: IDが重複
#     500: 想定外の障害
#     """
#     data = request.get_json()

#     required = ["id", "name", "description"]
#     if not data or not all(key in data for key in required):
#         return {
#             "error": "id, name, and description are required"
#         }, 400
    
#     individual = Individual(
#         id=data["id"],
#         name=data["name"],
#         description=data["description"],
#     )

#     try:
#         with Session(engine) as session:
#             session.add(individual)
#             session.commit()

#             # Sessionが生きているうちに値を取得
#             result = {
#                 "id": individual.id,
#                 "name": individual.name,
#                 "description": individual.description,
#             }
#     except IntegrityError:
#         return {
#             "error": "Individual already exists",
#             "id": data["id"],
#         }, 409

#     return result, 201


@app.post("/api/individuals")
def create_individual():
    """POST
        
    201: 正常登録
    400: 入力がおかしい
    409: IDが重複
    500: 想定外の障害
    """
    id = request.form.get("id")
    name = request.form.get("name")
    description = request.form.get("description")
    file = request.files.get("photo")

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
    return send_from_directory(UPLOAD_DIR, filename)


# @app.post("/api/upload")
# def upload_file():
#     file = request.files.get("photo")

#     if file is None:
#         return {"error": "photo is required"}, 400

#     filename = secure_filename(file.filename)

#     if not filename:
#         return {"error": "invalid filename"}, 400

#     path = os.path.join(UPLOAD_DIR, filename)
#     file.save(path)

#     return {
#         "filename": filename,
#         "path": f"uploads/{filename}",
#     }, 201