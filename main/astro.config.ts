import { defineConfig } from "astro/config";
import viteTscPaths from "vite-tsconfig-paths";

export default defineConfig({
    output: "static",
    integrations: [],
    server: { port: 8000, host: "0.0.0.0" },
    trailingSlash: "ignore",
    vite: {
        plugins: [viteTscPaths()],
        build: { sourcemap: false },
    },
    prefetch: { defaultStrategy: "load", prefetchAll: true },
    devToolbar: { enabled: false },
});
