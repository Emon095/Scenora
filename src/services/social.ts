import { createClient } from "@/utils/supabase/client";

async function requireUser() {
  const supabase = createClient();
  const { data: { user }, error } = await supabase.auth.getUser();
  if (error || !user) throw new Error("Please log in to continue.");
  return { supabase, user };
}

export async function togglePostLove(postId: string, loved: boolean) {
  const { supabase, user } = await requireUser();
  const result = loved
    ? await supabase.from("post_likes").delete().match({ post_id: postId, user_id: user.id })
    : await supabase.from("post_likes").insert({ post_id: postId, user_id: user.id });
  if (result.error) throw result.error;
}

export async function addComment(postId: string, body: string) {
  const { supabase, user } = await requireUser();
  const { data, error } = await supabase.from("post_comments").insert({ post_id: postId, user_id: user.id, body: body.trim() }).select("id,body,created_at").single();
  if (error) throw error;
  return data;
}

export async function toggleFollow(followingId: string, following: boolean) {
  const { supabase, user } = await requireUser();
  const result = following
    ? await supabase.from("follows").delete().match({ follower_id: user.id, following_id: followingId })
    : await supabase.from("follows").insert({ follower_id: user.id, following_id: followingId });
  if (result.error) throw result.error;
}

export async function toggleBookmark(titleId: string, saved: boolean) {
  const { supabase, user } = await requireUser();
  const result = saved
    ? await supabase.from("saved_movies").delete().match({ user_id: user.id, title_id: titleId })
    : await supabase.from("saved_movies").insert({ user_id: user.id, title_id: titleId });
  if (result.error) throw result.error;
}

export async function recordShare(postId: string) {
  const { supabase, user } = await requireUser();
  const { error } = await supabase.from("post_shares").insert({ post_id: postId, user_id: user.id });
  if (error) throw error;
}
