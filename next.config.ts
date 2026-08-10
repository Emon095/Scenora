import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  output: "export",
  trailingSlash: true,
  basePath: process.env.GITHUB_ACTIONS ? "/Scenora" : "",
  env: { NEXT_PUBLIC_BASE_PATH: process.env.GITHUB_ACTIONS ? "/Scenora" : "" },
  images: {
    unoptimized: true,
    remotePatterns: [{ protocol: "https", hostname: "image.tmdb.org" }, { protocol: "https", hostname: "i.pravatar.cc" }],
  },
};

export default nextConfig;
