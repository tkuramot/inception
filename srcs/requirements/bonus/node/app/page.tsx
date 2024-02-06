import Image from "next/image";

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      <div className="">
        <Image
          src="/elephants.jpg"
          alt="elephants"
          width={400}
          height={300}
          priority
        />
      </div>
    </main>
  );
}
