# Checklist de Deploy — SST Psicossocial
## Siga cada item em ordem. Marque com ✅ ao concluir.

---

## PARTE 1 — Supabase (banco de dados)

### 1.1 Criar conta e projeto
- [ ] Acessar https://supabase.com e criar conta gratuita
- [ ] Clicar em **New Project**
- [ ] Preencher: nome do projeto, senha do banco, região (South America)
- [ ] Aguardar projeto inicializar (~1 minuto)

### 1.2 Criar a tabela
- [ ] No menu lateral, clicar em **SQL Editor**
- [ ] Abrir o arquivo `supabase_setup.sql` (incluso neste ZIP)
- [ ] Copiar todo o conteúdo e colar no SQL Editor
- [ ] Clicar em **Run** (▶)
- [ ] Verificar que aparece: `"Tabela respostas criada com sucesso!"`

### 1.3 Copiar credenciais
- [ ] No menu lateral, clicar em **Settings → API**
- [ ] Copiar e salvar em local seguro:
  - **Project URL** → `https://xxxxxxxx.supabase.co`
  - **anon public** key → `eyJhbGci...`

---

## PARTE 2 — Vercel (hospedagem)

### 2.1 Criar conta
- [ ] Acessar https://vercel.com
- [ ] Criar conta gratuita (recomendado: entrar com GitHub)

### 2.2 Criar projeto e fazer upload
- [ ] Clicar em **Add New → Project**
- [ ] Clicar em **"Upload"** ou arrastar a pasta `sst-deploy`
- [ ] **NÃO clicar em Deploy ainda** — primeiro adicionar variáveis

### 2.3 Configurar variáveis de ambiente ⚠️ (OBRIGATÓRIO)
- [ ] Na tela de deploy, clicar em **Environment Variables**
- [ ] Adicionar as 3 variáveis abaixo:

| Nome | Valor |
|------|-------|
| `VITE_SUPABASE_URL` | URL copiada do Supabase |
| `VITE_SUPABASE_ANON_KEY` | anon key copiada do Supabase |
| `VITE_ADMIN_PASS` | senha que você escolher para o painel |

- [ ] Para cada variável: marcar **Production ✓**, **Preview ✓**, **Development ✓**

### 2.4 Fazer o deploy
- [ ] Clicar em **Deploy**
- [ ] Aguardar build (~1-2 minutos)
- [ ] Verificar que aparece: **"Congratulations! Your project has been deployed"**
- [ ] Copiar a URL gerada (ex: `https://sst-psicossocial-xyz.vercel.app`)

---

## PARTE 3 — Validar o sistema

### 3.1 Teste do formulário
- [ ] Abrir a URL no celular e no computador
- [ ] Clicar em **"Formulário de Avaliação"**
- [ ] Preencher todos os campos e clicar em **Enviar**
- [ ] Verificar mensagem: `"Enviado com sucesso!"`

### 3.2 Teste do painel admin
- [ ] Voltar ao início e clicar em **"Painel Administrativo"**
- [ ] Entrar com a senha definida em `VITE_ADMIN_PASS`
- [ ] Verificar que a resposta de teste aparece no Dashboard
- [ ] Verificar aba **Respostas** — deve mostrar o registro

### 3.3 Teste de IA (opcional)
- [ ] No painel, acessar aba **Relatório IA**
- [ ] Clicar em **Gerar Relatório** — aguardar ~10s
- [ ] Verificar que o relatório é gerado sem erros

---

## PARTE 4 — Distribuição (após tudo funcionando)

### 4.1 Compartilhar com funcionários
- [ ] Copiar a URL do site (ex: `https://sst-psicossocial.vercel.app`)
- [ ] Enviar por WhatsApp, e-mail ou QR Code
- [ ] Instruir: "Clique em Formulário de Avaliação e responda"

### 4.2 Domínio customizado (opcional)
- [ ] Na Vercel: **Settings → Domains → Add Domain**
- [ ] Ex: `sst.armpreine.com.br`
- [ ] Configurar DNS conforme instrução da Vercel (CNAME)

### 4.3 Monitorar respostas
- [ ] Acessar painel admin regularmente
- [ ] Clicar em **↺ Atualizar** para ver novas respostas
- [ ] Exportar CSV para relatórios em Excel

---

## SOLUÇÃO DE PROBLEMAS

### Site abre mas não conecta ao Supabase
→ Verifique se as variáveis `VITE_SUPABASE_URL` e `VITE_SUPABASE_ANON_KEY` foram salvas na Vercel
→ Vá em: Vercel → Project → Settings → Environment Variables
→ Após corrigir: clique em **Redeploy** (sem cache)

### Build falha na Vercel com erro de Node
→ Verifique que o Node.js está em ≥18 nas configurações do projeto
→ Vercel → Settings → General → Node.js Version → 20.x

### Erro "relation respostas does not exist"
→ O SQL de setup não foi executado ou falhou
→ Acesse Supabase → SQL Editor → execute o arquivo `supabase_setup.sql` novamente

### Painel admin não aparece respostas
→ Clique em **↺ Atualizar**
→ Verifique se os filtros estão em branco (empresa, setor, data)

---

## INFORMAÇÕES DO PROJETO

- **Runtime:** Node.js 18+ / Vite 5 (frontend estático)
- **Banco:** Supabase (PostgreSQL)
- **Hospedagem:** Vercel (CDN global)
- **IA:** Anthropic API (claude-sonnet-4-20250514)
- **Custo:** R$ 0,00 (tudo no plano gratuito)
