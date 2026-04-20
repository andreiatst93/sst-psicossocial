import { defineConfig, loadEnv } from 'vite'

export default defineConfig(({ mode }) => {
  // Carrega .env do diretório raiz
  const env = loadEnv(mode, process.cwd(), '')

  return {
    build: {
      outDir: 'dist',
      assetsDir: 'assets',
      sourcemap: false,
      minify: 'esbuild',
      rollupOptions: {
        input: 'index.html'
      }
    },
    server: {
      port: 3000
    },
    // Injeta variáveis de ambiente no bundle como constantes globais
    // Assim o index.html pode usar __SUPABASE_URL__ etc. sem expor no .env
    define: {
      __SUPABASE_URL__: JSON.stringify(env.VITE_SUPABASE_URL || ''),
      __SUPABASE_KEY__: JSON.stringify(env.VITE_SUPABASE_ANON_KEY || ''),
      __ADMIN_PASS__:   JSON.stringify(env.VITE_ADMIN_PASS || 'admin123'),
    }
  }
})
