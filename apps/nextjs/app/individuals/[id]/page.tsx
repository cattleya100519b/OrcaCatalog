import Link from "next/link";
import styles from "./page.module.css";

type Props = {
  params: Promise<{ id: string }>;
};

type Individual = {
  id: string;
  name: string;
  description: string;
  photo_path: string | null;
};

export default async function IndividualPage({ params }: Props) {
  const { id } = await params;

  const response = await fetch(`http://api:5000/api/individuals/${id}`, {
    cache: "no-store",
  });

  if (!response.ok) {
    return (
      <main className="container">
        <p>個体が見つかりません。</p>
      </main>
    );
  }

  const individual: Individual = await response.json();

  return (
    <main className="container">
      <p className="eyebrow">OrcaCatalog</p>

      <Link href="/" className={styles.backLink}>
        ← 個体一覧に戻る
      </Link>

      <section className={styles.individualDetail}>
        <div className={styles.detailPhoto}>
          {individual.photo_path ? (
            <img
              src={`http://localhost:5001/uploads/${individual.photo_path}`}
              alt={individual.name}
            />
          ) : (
            <span>Photo</span>
          )}
        </div>

        <div>
          <p className="eyebrow">Individual</p>
          <h1>{individual.name}</h1>

          <dl className={styles.info}>
            <div>
              <dt>識別番号</dt>
              <dd>{individual.id}</dd>
            </div>

            <div>
              <dt>説明</dt>
              <dd>{individual.description}</dd>
            </div>

            <div>
              <dt>性別</dt>
              <dd>Unknown</dd>
            </div>

            <div>
              <dt>ステータス</dt>
              <dd>Known individual</dd>
            </div>
          </dl>
        </div>
      </section>
    </main>
  );
}
