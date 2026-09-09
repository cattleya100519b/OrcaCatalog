"use client";

import Link from "next/link";
import { useState } from "react";
import styles from "./page.module.css";

export default function RegisterPage() {
  const [preview, setPreview] = useState<string | null>(null);
  const [file, setFile] = useState<File | null>(null);
  const [id, setId] = useState("");
  const [name, setName] = useState("");
  const [description, setDescription] = useState("");
  const [error, setError] = useState<string | null>(null);

  const handleFileChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];

    if (!file) {
      return;
    }

    setFile(file);
    setPreview(URL.createObjectURL(file));
  };

  const handleSubmit = async () => {
    setError(null);

    if (!id || !name || !description) {
      setError("ID、個体名、説明を入力してください");
      return;
    }

    // const fileInput = document.querySelector(
    //   'input[type="file"]',
    // ) as HTMLInputElement | null;

    // const file = fileInput?.files?.[0];

    if (!file) {
      setError("写真を選択してください");
      return;
    }

    const formData = new FormData();

    formData.append("id", id);
    formData.append("name", name);
    formData.append("description", description);
    formData.append("photo", file);

    const response = await fetch("http://localhost:5001/api/individuals", {
      method: "POST",
      body: formData,
    });

    if (!response.ok) {
      const data = await response.json();
      setError(data.error ?? "登録に失敗しました");
      return;
    }

    window.location.href = "/";
  };

  return (
    <main className="container">
      <p className="eyebrow">OrcaCatalog</p>

      <Link href="/" className="backLink">
        ← 個体一覧に戻る
      </Link>

      <h1>写真を登録</h1>

      <div className={styles.uploadForm}>
        {!preview && (
          <label className={styles.fileInput}>
            <span>写真を選択</span>
            <input type="file" accept="image/*" onChange={handleFileChange} />
          </label>
        )}

        {preview && (
          <>
            <div className={styles.preview}>
              <img src={preview} alt="選択した写真のプレビュー" />
            </div>

            <label className={styles.changeButton}>
              写真を変更
              <input type="file" accept="image/*" onChange={handleFileChange} />
            </label>
          </>
        )}

        <div>
          <label>
            ID
            <input
              type="text"
              value={id}
              onChange={(e) => setId(e.target.value)}
              placeholder="K-005"
            />
          </label>
        </div>

        <div>
          <label>
            個体名
            <input
              type="text"
              value={name}
              onChange={(e) => setName(e.target.value)}
              placeholder="K-005"
            />
          </label>
        </div>

        <div>
          <label>
            説明
            <input
              type="text"
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              placeholder="Adult · Known individual"
            />
          </label>
        </div>

        {error && <p>{error}</p>}

        <div className={styles.formActions}>
          <button type="button" disabled={!preview} onClick={handleSubmit}>
            登録する
          </button>
        </div>
      </div>
    </main>
  );
}
