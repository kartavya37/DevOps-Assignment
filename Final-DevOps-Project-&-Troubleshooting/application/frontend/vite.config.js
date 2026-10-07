import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

// "npm run dev" sends /api calls to a backend on port 8000 (uvicorn or Docker Compose).
export default defineConfig({
  plugins: [react()],
  server: { port: 5173, proxy: { '/api': 'http://localhost:8000' } },
});
