import Link from "next/link";

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
  return (
    <main className="container">
      <header className="header">
        <div>
          <p className="eyebrow">OrcaCatalog</p>
          <h1>個体を探す</h1>
        </div>

        {/* <button className="registerButton">写真を登録</button> */}
        <Link href="/register" className="registerButton">
          写真を登録
        </Link>
      </header>

      <div className="search">
        <input
          type="search"
          placeholder="個体名・IDを検索"
          aria-label="個体名・IDを検索"
        />
      </div>

      <section className="grid" aria-label="個体一覧">
        {individuals.map((individual) => (
          <Link
            className="card"
            key={individual.id}
            href={`/individuals/${individual.id}`}
          >
            <div className="photoPlaceholder">
              <span>Photo</span>
            </div>

            <div className="cardBody">
              <h2>{individual.name}</h2>
              <p>{individual.description}</p>
            </div>
          </Link>
        ))}
      </section>
    </main>
  );
}
