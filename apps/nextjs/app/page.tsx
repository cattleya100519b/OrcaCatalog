"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import styles from "./page.module.css";

/**
 * 個体一覧で扱う個体データ
 */
type Individual = {
  id: string;
  name: string;
  description: string;
  photo_path: string | null;
};

/**
 * 個体の検索と一覧表示を行うホーム画面
 */
export default function Home() {
  const [query, setQuery] = useState("");
  const [individuals, setIndividuals] = useState<Individual[]>([]);

  useEffect(() => {
    fetch("http://localhost:5001/api/individuals")
      .then((response) => response.json())
      .then((data) => setIndividuals(data));
  }, []);

  const filteredIndividuals = individuals.filter(
    (individual) =>
      individual.id.toLowerCase().includes(query.toLowerCase()) ||
      individual.name.toLowerCase().includes(query.toLowerCase()),
  );

  return (
    <main className="container">
      <header className={styles.header}>
        <div>
          <p className="eyebrow">OrcaCatalog</p>
          <h1>個体を探す</h1>
        </div>

        <Link href="/register" className={styles.registerButton}>
          写真を登録
        </Link>
      </header>

      <div className={styles.search}>
        <input
          type="search"
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          placeholder="個体名・IDを検索"
        />
      </div>

      <section className={styles.grid} aria-label="個体一覧">
        {filteredIndividuals.map((individual) => (
          <Link
            className={styles.card}
            key={individual.id}
            href={`/individuals/${individual.id}`}
          >
            {individual.photo_path ? (
              <img
                className={styles.photo}
                src={`http://localhost:5001/uploads/${individual.photo_path}`}
                alt={individual.name}
              />
            ) : (
              <div className={styles.photoPlaceholder}>
                <span>Photo</span>
              </div>
            )}

            <div className={styles.cardBody}>
              <h2>{individual.name}</h2>
              <p>{individual.description}</p>
            </div>
          </Link>
        ))}
      </section>
    </main>
  );
}
