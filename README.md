# SST Psicossocial — ARM Previne
## Deploy na Vercel em 5 minutos

---

## PRÉ-REQUISITO: Banco de dados Supabase

1. Acesse **https://supabase.com** → conta gratuita → **New Project**
2. Aguarde ~1 min o projeto inicializar
3. Vá em **SQL Editor** e execute:

```sql
CREATE TABLE respostas (
  id TEXT PRIMARY KEY,
  empresa TEXT,
  setor TEXT,
  funcao TEXT,
  atividade TEXT,
  tempo TEXT,
  respostas JSONB,
  scores JSONB,
  data TEXT,
  hora TEXT,
  timestamp BIGINT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE respostas ENABLE ROW LEVEL SECURITY;
CREATE POLICY "allow_insert" ON respostas FOR INSERT WITH CHECK (true);
CREATE POLICY "allow_select" ON respostas FOR SELECT USING (true);
CREATE POLICY "allow_delete" ON respostas FOR DELETE USING (true);
```

4. Vá em **Settings → API** e copie:
   - `Project URL`  → será `VITE_SUPABASE_URL`
   - `anon public key` → será `VITE_SUPABASE_ANON_KEY`

---

## DEPLOY NA VERCEL

### Opção A — Drag & Drop (mais rápida, sem GitHub)

1. Acesse **https://vercel.com** → login gratuito
2. Clique **Add New → Project**
3. Clique em **"browse"** e selecione esta pasta `sst-deploy`
4. Em **Environment Variables**, adicione as 3 variáveis abaixo
5. Clique em **Deploy**

### Opção B — Via GitHub (recomendado para atualizações)

```bash
# 1. Crie repositório no github.com e clone
git init
git remote add origin https://github.com/SEU_USUARIO/sst-psicossocial.git

# 2. Primeiro commit
git add .
git commit -m "chore: deploy inicial"
git push -u origin main

# 3. Na Vercel: Add New Project → Import Git Repository
# 4. Adicione as variáveis de ambiente e clique Deploy
```

---

## VARIÁVEIS DE AMBIENTE (obrigatórias)

Configure em: **Vercel → Project → Settings → Environment Variables**

| Variável | Valor | Descrição |
|---|---|---|
| `VITE_SUPABASE_URL` | `https://xxx.supabase.co` | URL do projeto Supabase |
| `VITE_SUPABASE_ANON_KEY` | `eyJhbGci...` | Chave anônima pública |
| `VITE_ADMIN_PASS` | `sua_senha_aqui` | Senha do painel admin |

> ⚠️ Marque todas como **Production + Preview + Development**

---

## DESENVOLVIMENTO LOCAL

```bash
# 1. Copie o arquivo de exemplo
cp .env.example .env

# 2. Preencha com suas credenciais do Supabase
nano .env   # ou abra no VS Code

# 3. Instale dependências e rode
npm install
npm run dev
# Acesse: http://localhost:3000
```

---

## VALIDAÇÃO PÓS-DEPLOY

```bash
# Teste a URL raiz
curl -I https://SEU-PROJETO.vercel.app

# Deve retornar:
# HTTP/2 200
# content-type: text/html
```

Checklist:
- [ ] URL abre no navegador
- [ ] Formulário carrega e permite envio
- [ ] Resposta aparece no painel admin
- [ ] Relatório IA funciona (requer API Anthropic configurada)

---

## ESTRUTURA DO PROJETO

```
sst-deploy/
├── index.html        ← Aplicação completa (SPA)
├── package.json      ← Dependências (Supabase + Vite)
├── vite.config.js    ← Build + injeção de env vars
├── vercel.json       ← Configuração de deploy
├── .env.example      ← Template de variáveis (NÃO commitar .env)
├── .gitignore        ← Ignora node_modules, dist, .env
└── README.md         ← Este arquivo
```

---

## CAPACIDADE

| Serviço | Plano gratuito |
|---|---|
| Vercel | 100 GB banda/mês, deploys ilimitados |
| Supabase | 500 MB banco, 50.000 linhas, sem limite de requests |

**Suporta centenas de funcionários simultâneos** sem custo.

---

## ALTERAR SENHA DO ADMIN

Na Vercel: **Settings → Environment Variables → VITE_ADMIN_PASS** → novo valor → **Redeploy**.

Nunca altere diretamente no código.
