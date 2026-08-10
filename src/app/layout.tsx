import type { Metadata, Viewport } from "next";
import "./globals.css";

export const metadata: Metadata = { title: "SCENORA — Discover. Watch. Share.", description: "The social platform for true movie lovers." };
export const viewport: Viewport = { width: "device-width", initialScale: 1, themeColor: "#030405" };
export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) { return <html lang="en"><body>{children}</body></html>; }
