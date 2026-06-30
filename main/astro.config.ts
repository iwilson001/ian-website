import { defineConfig } from 'astro/config';

export default defineConfig({
    output: 'static',
    integrations: [],
    server: { port: 8000, host: '0.0.0.0' },
    trailingSlash: 'ignore',
    vite: { plugins: [], build: { sourcemap: false }, resolve: { tsconfigPaths: true } },
    prefetch: { defaultStrategy: 'load', prefetchAll: true },
    devToolbar: { enabled: false },
});
