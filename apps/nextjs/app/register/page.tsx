
"use client";

import Link from "next/link";
import { useState } from "react";

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

      <div className="uploadForm">
        {!preview && (
        <label className="fileInput">
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
                <div className="preview">
                <img src={preview} alt="選択した写真のプレビュー" />
                </div>

                <label className="changeButton">
                写真を変更
                <input
                    type="file"
                    accept="image/*"
                    onChange={handleFileChange}
                />
                </label>
            </>
        )}

        <div className="formActions">
          <button type="button" disabled={!preview}>
            登録する
          </button>
        </div>
      </div>
    </main>
  );
}