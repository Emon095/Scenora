"use client";

import { ChangeEvent, useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { BarChart3, Image as ImageIcon, List, Star, Video } from "lucide-react";
import { Shell } from "@/components/Shell";
import { genres } from "@/data/demo";
import { RatingStars } from "@/components/RatingStars";
import { createClient } from "@/utils/supabase/client";

type TitleResult = { id: string; title: string; type: "movie" | "series"; release_date: string | null };

export default function CreatePost() {
  const router = useRouter();
  const [text, setText] = useState("");
  const [rating, setRating] = useState(0);
  const [visibility, setVisibility] = useState("public");
  const [spoiler, setSpoiler] = useState(false);
  const [commentsEnabled, setCommentsEnabled] = useState(true);
  const [feeling, setFeeling] = useState<string | null>(null);
  const [tags, setTags] = useState<string[]>([]);
  const [files, setFiles] = useState<File[]>([]);
  const [movieQuery, setMovieQuery] = useState("");
  const [results, setResults] = useState<TitleResult[]>([]);
  const [selectedTitle, setSelectedTitle] = useState<TitleResult | null>(null);
  const [toast, setToast] = useState("");
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    if (movieQuery.trim().length < 2 || selectedTitle) { setResults([]); return; }
    const timeout = setTimeout(async () => {
      const { data } = await createClient().from("titles").select("id,title,type,release_date").ilike("title", `%${movieQuery.trim()}%`).limit(8);
      setResults((data as TitleResult[] | null) ?? []);
    }, 300);
    return () => clearTimeout(timeout);
  }, [movieQuery, selectedTitle]);

  function selectFiles(event: ChangeEvent<HTMLInputElement>) {
    setFiles(Array.from(event.target.files ?? []).slice(0, 5));
  }

  async function submit() {
    if (!text.trim()) { setToast("Write something before posting"); return; }
    setSubmitting(true);
    setToast("");
    const supabase = createClient();
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) { setSubmitting(false); setToast("Please log in to create a post."); return; }

    const { data: post, error } = await supabase.from("posts").insert({
      author_id: user.id,
      title_id: selectedTitle?.id ?? null,
      body: text.trim(), visibility, spoiler, comments_enabled: commentsEnabled,
      feeling, tags,
    }).select("id").single();
    if (error || !post) { setSubmitting(false); setToast(error?.message ?? "Unable to create post"); return; }

    if (selectedTitle && rating > 0) {
      const { error: reviewError } = await supabase.from("reviews").insert({ post_id: post.id, title_id: selectedTitle.id, user_id: user.id, rating });
      if (reviewError) { await supabase.from("posts").delete().eq("id", post.id); setSubmitting(false); setToast(reviewError.message); return; }
    }

    for (const [index, file] of files.entries()) {
      const safeName = file.name.replace(/[^a-zA-Z0-9._-]/g, "_");
      const path = `${user.id}/${post.id}/${crypto.randomUUID()}-${safeName}`;
      const { error: uploadError } = await supabase.storage.from("post-media").upload(path, file, { contentType: file.type, upsert: false });
      if (uploadError) { setToast(`Post saved, but an image failed: ${uploadError.message}`); continue; }
      const { data: publicUrl } = supabase.storage.from("post-media").getPublicUrl(path);
      await supabase.from("post_images").insert({ post_id: post.id, url: publicUrl.publicUrl, sort_order: index });
    }

    setSubmitting(false);
    setToast("Post published");
    setTimeout(() => router.push("/home"), 500);
  }

  return <Shell back nav={false}>
    {toast && <div className="toast">{toast}</div>}
    <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}><h1 className="page-title">Create Post</h1><button className="gradient-btn" onClick={submit} disabled={submitting}>{submitting ? "Posting…" : "Post"}</button></div>
    <div className="form-card"><h2>Your SCENORA Account</h2><select className="pill" value={visibility} onChange={event => setVisibility(event.target.value)}><option value="public">🌐 Public</option><option value="followers">Followers</option><option value="private">Private</option></select></div>
    <div className="card form-card"><textarea className="field textarea" maxLength={1000} value={text} onChange={event => setText(event.target.value)} placeholder="What’s on your mind about movies?" /><div className="muted" style={{ textAlign: "right" }}>{text.length}/1000</div></div>
    <div className="tabs">{[[ImageIcon,"Photo"],[Video,"Video"],[Star,"Review"],[BarChart3,"Poll"],[List,"Add to List"]].map(([Icon,label]) => { const I = Icon as typeof Star; return <button className="pill" key={String(label)}><I className="orange" /> {String(label)}</button>; })}</div>
    <section className="card form-card"><h3>Add Movie / Series <small className="muted">(Optional)</small></h3><input className="field" value={movieQuery} onChange={event => { setMovieQuery(event.target.value); setSelectedTitle(null); }} placeholder="Search your Supabase movie catalog" />{results.map(title => <button className="menu-item" style={{ width: "100%" }} key={title.id} onClick={() => { setSelectedTitle(title); setMovieQuery(title.title); setResults([]); }}>{title.title} <span className="muted">{title.type}</span></button>)}</section>
    <section className="card form-card"><h3>Your Rating <small className="muted">(Optional)</small></h3><div style={{ display: "flex", gap: 14, alignItems: "center" }}><div onClick={() => setRating(rating === 5 ? 0 : rating + 1)} style={{ cursor: "pointer" }}><RatingStars rating={rating} /></div><span className="muted">{selectedTitle ? `${rating}/5` : "Choose a movie first"}</span></div></section>
    <section className="card form-card"><h3>How did you feel?</h3><div className="tabs">{[["like","👍 Like"],["love","💗 Love"],["wow","😮 Wow"],["haha","😄 Haha"],["sad","😢 Sad"],["angry","😡 Angry"]].map(([value,label]) => <button className={`pill ${feeling === value ? "active" : ""}`} onClick={() => setFeeling(value)} key={value}>{label}</button>)}</div></section>
    <section className="card form-card"><h3>Add Images <small className="muted">({files.length}/5)</small></h3><label className="pill orange" style={{ display: "inline-grid", placeItems: "center", height: 100, width: 100, fontSize: 40, cursor: "pointer" }}>＋<input hidden type="file" accept="image/*" multiple onChange={selectFiles} /></label>{files.map(file => <span className="muted" key={file.name} style={{ display: "block" }}>{file.name}</span>)}</section>
    <section className="card form-card"><h3>Add Tags</h3><div className="tabs">{genres.slice(0,8).map(tag => <button className={`pill ${tags.includes(tag) ? "active" : ""}`} onClick={() => setTags(current => current.includes(tag) ? current.filter(item => item !== tag) : [...current, tag])} key={tag}>#{tag}</button>)}</div></section>
    <section className="card form-card"><h3>More Options</h3><label>Spoiler <input type="checkbox" checked={spoiler} onChange={event => setSpoiler(event.target.checked)} /></label><label style={{ marginLeft: 40 }}>Allow Comments <input type="checkbox" checked={commentsEnabled} onChange={event => setCommentsEnabled(event.target.checked)} /></label></section>
  </Shell>;
}
