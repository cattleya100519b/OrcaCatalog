import Link from "next/link";
import styles from "./page.module.css";

type Props = {
  params: Promise<{ id: string }>;
};

export default async function IndividualPage({ params }: Props) {
  const { id } = await params;

  return (
    <main className="container">
      <p className="eyebrow">OrcaCatalog</p>

      <Link href="/" className={styles.backLink}>
        ← 個体一覧に戻る
      </Link>

      <section className={styles.individualDetail}>
        <div className={styles.detailPhoto}>
          <span>Photo</span>
        </div>

        <div>
          <p className="eyebrow">Individual</p>
          <h1>{id}</h1>

          <dl className={styles.info}>
            <div>
              <dt>識別番号</dt>
              <dd>{id}</dd>
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
