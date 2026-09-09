"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import styles from "./page.module.css";

// const individuals = [
//   {
//     id: "K-001",
//     name: "K-001",
//     description: "Adult · Known individual",
//   },
//   {
//     id: "K-002",
//     name: "K-002",
//     description: "Adult · Known individual",
//   },
//   {
//     id: "K-003",
//     name: "K-003",
//     description: "Juvenile · Known individual",
//   },
//   {
//     id: "K-004",
//     name: "K-004",
//     description: "Adult · Known individual",
//   },
// ];

type Individual = {
  id: string;
  name: string;
  description: string;
  photo_path: string | null;
};

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
            {/* <div className={styles.photoPlaceholder}>
              <span>Photo</span>
            </div> */}
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
  // return (
  //   <main>
  //     <h1>OrcaCatalog</h1>

  //     {individuals.map((individual) => (
  //       <div key={individual.id}>
  //         <h2>{individual.name}</h2>
  //         <p>{individual.description}</p>
  //       </div>
  //     ))}
  //   </main>
  // );
}
