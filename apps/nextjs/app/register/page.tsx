"use client";

import Link from "next/link";
import { useState } from "react";
import styles from "./page.module.css";

export default function RegisterPage() {
  const [preview, setPreview] = useState<string | null>(null);

  const handleFileChange = (
    event: React.ChangeEvent<HTMLInputElement>,
  ) => {
    const file = event.target.files?.[0];

    if (!file) {
      return;
    }

    setPreview(URL.createObjectURL(file));
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
            <input
            type="file"
            accept="image/*"
            onChange={handleFileChange}
            />
        </label>
        )}

        {preview && (
            <>
                <div className={styles.preview}>
                <img src={preview} alt="選択した写真のプレビュー" />
                </div>

                <label className={styles.changeButton}>
                写真を変更
                <input
                    type="file"
                    accept="image/*"
                    onChange={handleFileChange}
                />
                </label>
            </>
        )}

        <div className={styles.formActions}>
          <button type="button" disabled={!preview}>
            登録する
          </button>
        </div>
      </div>
    </main>
  );
}