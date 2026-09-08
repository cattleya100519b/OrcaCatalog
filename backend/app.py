import os

import psycopg
from flask import Flask

app = Flask(__name__)


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