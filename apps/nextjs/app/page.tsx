"use client";

import Link from "next/link";
import { useState } from "react";
import styles from "./page.module.css";

const individuals = [
  {
    id: "K-001",
    name: "K-001",
    description: "Adult · Known individual",
  },
  {
    id: "K-002",
    name: "K-002",
    description: "Adult · Known individual",
  },
  {
    id: "K-003",
    name: "K-003",
    description: "Juvenile · Known individual",
  },
  {
    id: "K-004",
    name: "K-004",
    description: "Adult · Known individual",
  },
];

export default function Home() {
  const [query, setQuery] = useState("");

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
            <div className={styles.photoPlaceholder}>
              <span>Photo</span>
            </div>

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
