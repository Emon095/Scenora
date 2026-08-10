"use client";

import Image from "next/image";
import { FormEvent, useCallback, useEffect, useMemo, useState } from "react";
import { Mic, Paperclip, Send } from "lucide-react";
import { Shell } from "@/components/Shell";
import { createClient } from "@/utils/supabase/client";

type Message = {
  id: string;
  user_id: string;
  body: string | null;
  type: "text" | "image" | "voice";
  media_url: string | null;
  created_at: string;
  shoutbox_reactions: { user_id: string; reaction: string }[];
  users: { username: string; profiles: { display_name: string; avatar_url: string | null } | null } | null;
};

export default function Shoutbox() {
  const supabase = useMemo(() => createClient(), []);
  const [messages, setMessages] = useState<Message[]>([]);
  const [text, setText] = useState("");
  const [online, setOnline] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  const loadMessages = useCallback(async () => {
    const { data, error: queryError } = await supabase
      .from("shoutbox_messages")
      .select("id,user_id,body,type,media_url,created_at,users(username,profiles(display_name,avatar_url)),shoutbox_reactions(user_id,reaction)")
      .order("created_at", { ascending: false })
      .limit(100);
    if (queryError) setError(queryError.message);
    else setMessages((data as unknown as Message[]).reverse());
    setLoading(false);
  }, [supabase]);

  useEffect(() => {
    void loadMessages();
    const channel = supabase.channel("scenora-global-shoutbox", { config: { presence: { key: crypto.randomUUID() } } })
      .on("postgres_changes", { event: "INSERT", schema: "public", table: "shoutbox_messages" }, () => void loadMessages())
      .on("presence", { event: "sync" }, () => setOnline(Object.keys(channel.presenceState()).length))
      .subscribe(async (status: string) => {
        if (status === "SUBSCRIBED") await channel.track({ online_at: new Date().toISOString() });
      });
    return () => { void supabase.removeChannel(channel); };
  }, [loadMessages, supabase]);

  async function send(event: FormEvent) {
    event.preventDefault();
    const body = text.trim();
    if (!body) return;
    setError("");
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) {
      setError("Please log in to join the Shoutbox.");
      return;
    }
    setText("");
    const { error: insertError } = await supabase.from("shoutbox_messages").insert({ user_id: user.id, type: "text", body });
    if (insertError) { setText(body); setError(insertError.message); }
  }

  async function react(message: Message) {
    setError("");
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) { setError("Please log in to react."); return; }
    const reacted = message.shoutbox_reactions.some(item => item.user_id === user.id);
    const result = reacted
      ? await supabase.from("shoutbox_reactions").delete().match({ message_id: message.id, user_id: user.id })
      : await supabase.from("shoutbox_reactions").upsert({ message_id: message.id, user_id: user.id, reaction: "love" });
    if (result.error) setError(result.error.message); else await loadMessages();
  }

  return <Shell>
    <h1 className="page-title">Shoutbox <span className="pill active" style={{ fontSize: 12, padding: "7px 10px" }}>Live</span></h1>
    <p className="subtitle">Live chat with movie lovers &nbsp; <span style={{ color: "#4bd42a" }}>●</span> {online} Online</p>
    {loading && <p className="muted">Connecting to the global conversation…</p>}
    {error && <p style={{ color: "#ff5c5c" }}>{error}</p>}
    {!loading && !messages.length && <div className="card form-card muted">No messages yet. Start the conversation.</div>}
    <div className="chat-list">
      {messages.map(message => {
        const profile = message.users?.profiles;
        const name = profile?.display_name || message.users?.username || "Movie Lover";
        const avatar = profile?.avatar_url || `https://api.dicebear.com/9.x/initials/png?seed=${encodeURIComponent(name)}`;
        return <div className="chat" key={message.id}>
          <Image className="avatar" src={avatar} width={52} height={52} alt="" unoptimized />
          <div className="bubble"><b>{name}</b><small className="muted">{new Date(message.created_at).toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" })}</small><div style={{ marginTop: 8 }}>{message.body}</div><button className="action loved" onClick={() => void react(message)}>❤️ {message.shoutbox_reactions.length}</button></div>
        </div>;
      })}
    </div>
    <form className="chat-input" onSubmit={send}>
      <input className="field" value={text} onChange={event => setText(event.target.value)} maxLength={2000} placeholder="Type a message..." />
      <button type="button" className="icon-btn" aria-label="Attach media"><Paperclip /></button>
      <button type="button" className="icon-btn" aria-label="Voice message"><Mic /></button>
      <button className="gradient-btn" aria-label="Send"><Send /></button>
    </form>
  </Shell>;
}
