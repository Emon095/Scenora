"use client";

import Image from "next/image";
import { FormEvent, useState } from "react";
import { useRouter } from "next/navigation";
import { publicAsset } from "@/lib/assets";
import { createClient } from "@/utils/supabase/client";

export default function Login() {
  const router = useRouter();
  const [tab, setTab] = useState<"login" | "signup">("login");
  const [error, setError] = useState("");
  const [message, setMessage] = useState("");
  const [loading, setLoading] = useState(false);

  async function submit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setError("");
    setMessage("");
    setLoading(true);
    const form = new FormData(event.currentTarget);
    const email = String(form.get("email") ?? "").trim();
    const password = String(form.get("password") ?? "");
    const fullName = String(form.get("name") ?? "").trim();
    const username = String(form.get("username") ?? "").trim().toLowerCase();
    const supabase = createClient();

    const result = tab === "login"
      ? await supabase.auth.signInWithPassword({ email, password })
      : await supabase.auth.signUp({ email, password, options: { data: { full_name: fullName, username } } });

    setLoading(false);
    if (result.error) {
      setError(result.error.message);
      return;
    }
    if (tab === "signup" && !result.data.session) {
      setMessage("Account created. Check your email to confirm your address.");
      return;
    }
    router.push("/home");
  }

  async function signInWithGoogle() {
    setError("");
    const basePath = process.env.NEXT_PUBLIC_BASE_PATH ?? "";
    const { error: oauthError } = await createClient().auth.signInWithOAuth({
      provider: "google",
      options: { redirectTo: `${location.origin}${basePath}/home/` },
    });
    if (oauthError) setError(oauthError.message);
  }

  return <main className="login">
    <Image className="login-logo" src={publicAsset("/brand/scenora-logo.png")} width={706} height={313} alt="SCENORA" />
    <div style={{ textAlign: "center", marginBottom: 25 }}>
      <b style={{ letterSpacing: 7, fontSize: 20 }}>DISCOVER. <span className="orange">WATCH.</span> SHARE.</b>
      <p className="subtitle">Join a community of movie & series lovers.<br />Share reviews, ratings and your passion.</p>
    </div>
    <form className="card login-box" onSubmit={submit}>
      <div className="tabs">
        <button type="button" className={`pill ${tab === "login" ? "active" : ""}`} onClick={() => setTab("login")}>Login</button>
        <button type="button" className={`pill ${tab === "signup" ? "active" : ""}`} onClick={() => setTab("signup")}>Sign Up</button>
      </div>
      {tab === "signup" && <>
        <input className="field" name="name" placeholder="Full Name" required />
        <input className="field" name="username" placeholder="Username" pattern="[a-zA-Z0-9_]{3,30}" required />
      </>}
      <input className="field" name="email" type="email" placeholder="Email" required />
      <input className="field" name="password" type="password" minLength={8} placeholder="Password" required />
      {error && <p style={{ color: "#ff4d57" }}>{error}</p>}
      {message && <p style={{ color: "#42d47b" }}>{message}</p>}
      <div style={{ textAlign: "right", margin: "10px 0 25px" }} className="muted">Forgot Password?</div>
      <button className="gradient-btn" style={{ width: "100%" }} disabled={loading}>{loading ? "Please wait…" : tab === "login" ? "Login" : "Create Account"}</button>
      <div className="muted" style={{ textAlign: "center", margin: 25 }}>OR</div>
      <button type="button" className="pill" style={{ width: "100%" }} onClick={signInWithGoogle}>🇬 Continue with Google</button>
    </form>
  </main>;
}
