#!/usr/bin/env bash
# Claude na Mão — instalador idempotente
# Copia skills, agentes, CLAUDE.md, settings.json e .tmux.conf pro lugar certo.
# Roda quantas vezes quiser; não destrói nada sem perguntar.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

cor_azul='\033[1;34m'
cor_rosa='\033[1;35m'
cor_amarelo='\033[1;33m'
cor_verde='\033[1;32m'
cor_off='\033[0m'

echo -e "${cor_azul}┌────────────────────────────────────────┐${cor_off}"
echo -e "${cor_azul}│  Claude na Mão · instalador            │${cor_off}"
echo -e "${cor_azul}└────────────────────────────────────────┘${cor_off}"
echo

# ───── 1. Pré-requisitos ─────
echo -e "${cor_amarelo}[1/5]${cor_off} Verificando pré-requisitos..."

if ! command -v claude &> /dev/null; then
  echo "  ❌ Claude Code não encontrado. Instale primeiro:"
  echo "     npm install -g @anthropic-ai/claude-code"
  exit 1
fi
echo "  ✓ claude $(claude --version 2>/dev/null | head -1)"

if ! command -v tmux &> /dev/null; then
  echo "  ⚠️  tmux não encontrado."
  if command -v brew &> /dev/null; then
    read -p "  Instalar via brew? [Y/n] " -r resp
    if [[ ! $resp =~ ^[Nn] ]]; then
      brew install tmux
    fi
  else
    echo "     Instale com: brew install tmux"
  fi
else
  echo "  ✓ tmux $(tmux -V | cut -d' ' -f2)"
fi

# ───── 2. ~/.claude estrutura ─────
echo
echo -e "${cor_amarelo}[2/5]${cor_off} Preparando ~/.claude/..."
mkdir -p "$CLAUDE_DIR/skills" "$CLAUDE_DIR/agents"
echo "  ✓ ~/.claude/skills/ e ~/.claude/agents/ prontos"

# ───── 3. Skills ─────
echo
echo -e "${cor_amarelo}[3/5]${cor_off} Copiando skills..."
count=0
for skill_dir in "$REPO_DIR"/skills/*/; do
  name=$(basename "$skill_dir")
  if [ -d "$CLAUDE_DIR/skills/$name" ]; then
    echo "  ↻ $name (já existe — atualizando)"
    rm -rf "$CLAUDE_DIR/skills/$name"
  else
    echo "  + $name"
  fi
  cp -r "$skill_dir" "$CLAUDE_DIR/skills/"
  count=$((count + 1))
done
echo "  ✓ $count skills instaladas"

# ───── 4. Agentes ─────
echo
echo -e "${cor_amarelo}[4/5]${cor_off} Copiando agentes..."
count=0
for agent_file in "$REPO_DIR"/agents/*.md; do
  name=$(basename "$agent_file")
  if [ -f "$CLAUDE_DIR/agents/$name" ]; then
    echo "  ↻ $name (sobrescrevendo)"
  else
    echo "  + $name"
  fi
  cp "$agent_file" "$CLAUDE_DIR/agents/"
  count=$((count + 1))
done
echo "  ✓ $count agentes instalados"

# ───── 5. CLAUDE.md, settings.json, .tmux.conf ─────
echo
echo -e "${cor_amarelo}[5/5]${cor_off} Configurações..."

# CLAUDE.md — não sobrescreve se já existe (preserva customização)
if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
  echo "  ↻ ~/.claude/CLAUDE.md já existe — preservando seu (template salvo em CLAUDE.md.template)"
  cp "$REPO_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md.template"
else
  cp "$REPO_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
  echo "  + ~/.claude/CLAUDE.md (edite quando quiser personalizar)"
fi

# settings.json — merge cuidadoso ou copia se não existe
if [ -f "$CLAUDE_DIR/settings.json" ]; then
  echo "  ↻ ~/.claude/settings.json já existe — preservando (template em settings.json.template)"
  cp "$REPO_DIR/settings.json" "$CLAUDE_DIR/settings.json.template"
else
  cp "$REPO_DIR/settings.json" "$CLAUDE_DIR/settings.json"
  echo "  + ~/.claude/settings.json (allowlist sensata)"
fi

# .tmux.conf — só copia se não existe
if [ -f "$HOME/.tmux.conf" ]; then
  echo "  ↻ ~/.tmux.conf já existe — não mexido (template em $REPO_DIR/.tmux.conf)"
else
  cp "$REPO_DIR/.tmux.conf" "$HOME/.tmux.conf"
  echo "  + ~/.tmux.conf (mouse mode + scroll natural)"
fi

# ───── Pronto ─────
echo
echo -e "${cor_verde}┌────────────────────────────────────────┐${cor_off}"
echo -e "${cor_verde}│  ✓ Instalação concluída!               │${cor_off}"
echo -e "${cor_verde}└────────────────────────────────────────┘${cor_off}"
echo
echo "Próximos passos:"
echo
echo -e "  1. ${cor_rosa}tmux new -s claude${cor_off}"
echo -e "  2. ${cor_rosa}claude${cor_off}"
echo -e "  3. Digite: ${cor_amarelo}oi! lista as skills e agentes que você tem${cor_off}"
echo
echo "Pra desconectar do tmux sem matar: Ctrl+B depois D"
echo "Pra voltar:                          tmux attach -t claude"
echo
echo "Personalize seu Claude editando ~/.claude/CLAUDE.md quando quiser."
echo
