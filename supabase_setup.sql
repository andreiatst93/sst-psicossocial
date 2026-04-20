-- ==============================================
-- SST Psicossocial — ARM Previne
-- Execute no SQL Editor do Supabase
-- ==============================================

-- 1. Tabela principal de respostas
CREATE TABLE IF NOT EXISTS respostas (
  id           TEXT PRIMARY KEY,
  empresa      TEXT NOT NULL,
  setor        TEXT,
  funcao       TEXT,
  atividade    TEXT,
  tempo        TEXT,
  respostas    JSONB NOT NULL DEFAULT '{}',
  scores       JSONB NOT NULL DEFAULT '{}',
  data         TEXT,
  hora         TEXT,
  timestamp    BIGINT,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 2. Índices para performance (filtros do painel admin)
CREATE INDEX IF NOT EXISTS idx_respostas_empresa   ON respostas(empresa);
CREATE INDEX IF NOT EXISTS idx_respostas_setor     ON respostas(setor);
CREATE INDEX IF NOT EXISTS idx_respostas_timestamp ON respostas(timestamp DESC);
CREATE INDEX IF NOT EXISTS idx_respostas_created   ON respostas(created_at DESC);

-- 3. Segurança por linha (Row Level Security)
ALTER TABLE respostas ENABLE ROW LEVEL SECURITY;

-- Remove políticas antigas se existirem
DROP POLICY IF EXISTS "allow_insert" ON respostas;
DROP POLICY IF EXISTS "allow_select" ON respostas;
DROP POLICY IF EXISTS "allow_delete" ON respostas;

-- Permite que qualquer pessoa (anônima) insira respostas (formulário público)
CREATE POLICY "allow_insert" ON respostas
  FOR INSERT WITH CHECK (true);

-- Permite leitura (painel admin — a senha está no frontend)
CREATE POLICY "allow_select" ON respostas
  FOR SELECT USING (true);

-- Permite limpeza pelo admin
CREATE POLICY "allow_delete" ON respostas
  FOR DELETE USING (true);

-- 4. View de resumo por empresa (facilita dashboard)
CREATE OR REPLACE VIEW resumo_empresas AS
SELECT
  empresa,
  COUNT(*)                                          AS total_respostas,
  ROUND(AVG((scores->>'Geral')::numeric), 2)        AS score_medio,
  MAX(created_at)                                   AS ultima_resposta,
  COUNT(*) FILTER (
    WHERE scores->>'Classificacao' = 'Crítico'
  )                                                 AS qtd_critico,
  COUNT(*) FILTER (
    WHERE scores->>'Classificacao' = 'Alto'
  )                                                 AS qtd_alto,
  COUNT(*) FILTER (
    WHERE scores->>'Classificacao' = 'Moderado'
  )                                                 AS qtd_moderado,
  COUNT(*) FILTER (
    WHERE scores->>'Classificacao' = 'Baixo'
  )                                                 AS qtd_baixo
FROM respostas
GROUP BY empresa
ORDER BY total_respostas DESC;

-- 5. Confirmar criação
SELECT
  'Tabela respostas criada com sucesso!' AS status,
  COUNT(*) AS registros_atuais
FROM respostas;
