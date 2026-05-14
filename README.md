# Claude na Mão

> Kit pronto pra começar com Claude Code no Mac. 15 skills + 5 agentes especialistas + configuração que reduz prompts repetitivos. Cresce no seu ritmo.

🌐 **Site:** [docs/index.html](docs/index.html) (abra no navegador ou suba no Netlify)

---

## Pré-requisitos

- **Mac** com Terminal
- **Plano Pro** (ou superior) da Anthropic
- **Node.js** (instala junto se você não tiver)
- ~15 minutos pra primeira instalação

---

## Instalação em 5 passos

### 1. Instala Node, tmux e Claude Code

```bash
brew install node tmux
npm install -g @anthropic-ai/claude-code
```

### 2. Faz login

```bash
claude login
```

Abre o navegador, loga com sua conta Anthropic, volta pro Terminal.

### 3. Clona este repo e roda o instalador

```bash
git clone https://github.com/agencia-digd/claude-na-mao ~/claude-na-mao
cd ~/claude-na-mao
./install.sh
```

O instalador é **idempotente** — pode rodar quantas vezes quiser sem quebrar nada. Não sobrescreve `CLAUDE.md` ou `settings.json` se você já personalizou (salva como `.template`).

### 4. Abre uma sessão tmux persistente

```bash
tmux new -s claude
claude
```

- Pra sair sem matar a sessão: `Ctrl+B` depois `D`
- Pra voltar: `tmux attach -t claude`

### 5. Diz oi

No prompt do Claude:

```
oi! lista as skills e agentes que você tem disponíveis
```

Se ele responder com a lista, deu certo.

---

## O que vem instalado

### 15 Skills

| Skill | Pra quê |
|---|---|
| `copywriting-pro` | Copy persuasiva (ads, landing, email) com frameworks AIDA, PAS, BAB |
| `instagram-master` | Posts, Reels, carrosséis, calendário e estratégia de IG |
| `instagram-search` | Buscar perfis, hashtags e posts virais no IG |
| `content-marketing-strategy` | Plano de conteúdo + lead magnets |
| `content-repurposing-engine` | 1 conteúdo vira 10+ formatos |
| `landing-page-master` | Landing pages que convertem, anti-genéricas |
| `ffmpeg-video-editor` | Editar vídeo por linguagem natural |
| `gmail` | Ler, enviar, organizar email via API |
| `gog` | CLI completa pra Google Workspace |
| `google-calendar-api` | Eventos e disponibilidade no Calendar |
| `notion-cli` | Criar páginas, databases no Notion |
| `social-media-strategy` | Building-in-public, social listening |
| `social-media-agent` | Automação de X/Twitter |
| `jarvis-mission-control` | Hub de coordenação humano+IA |
| `find-skills` | Descobrir/instalar skills novas |

### 5 Agentes (orquestram skills num fluxo só)

| Agente | Faz |
|---|---|
| `social-creator` | Cria posts/reels/carrosséis com copy completa |
| `email-helper` | Triagem de inbox + respostas no seu tom |
| `video-cutter` | Edita vídeo conversando ("corta de 1:21 a 1:35") |
| `landing-builder` | Monta landing page que converte |
| `content-strategist` | Planeja calendário e analisa concorrentes |

---

## Estrutura do repo

```
claude-na-mao/
├── README.md          ← este arquivo
├── install.sh         ← instalador idempotente
├── CLAUDE.md          ← template de instruções permanentes
├── settings.json      ← allowlist sensata (reduz prompts)
├── .tmux.conf         ← config tmux amigável
├── skills/            ← 15 skills (copiadas pra ~/.claude/skills/)
├── agents/            ← 5 agentes (copiados pra ~/.claude/agents/)
├── docs/              ← site de apresentação (single-page HTML)
└── LICENSE            ← MIT
```

---

## Memória — começa simples, cresce no seu ritmo

O Claude Code **realmente lembra** entre sessões. Você tem 3 camadas:

1. **`CLAUDE.md`** — suas instruções permanentes (lê toda sessão)
2. **Auto Memory** — o Claude anota suas preferências em `~/.claude/projects/<cwd>/memory/`
3. **Sessão tmux viva** — tudo dentro de uma conversa fica disponível

**O que você não tem ainda:** busca semântica de "lembra quando conversamos sobre X meses atrás". Isso requer banco vetorial num servidor — fica pra quando você crescer (veja `docs/index.html` seção Roadmap).

---

## Roadmap pra crescer

Quando sentir necessidade (não antes):

- **Mês 2-3:** suas próprias skills (copia uma das 15 como template, adapta)
- **Mês 3-6:** MCPs (extensões com superpoderes — Linear, Slack, sua API)
- **Quando engatar:** memória semântica local (SQLite + sentence-transformers, sem custo)
- **Avançado:** bridges WhatsApp/Telegram (precisa servidor sempre-ligado)
- **Multi-máquina:** sync via git privado de `~/.claude/projects/.../memory/`

---

## Personalização

Tudo que está em `~/.claude/` é **seu** — edite à vontade:

- Adicione skills/agentes próprios
- Personalize o `CLAUDE.md` com seu nome, tom, áreas de atuação
- Ajuste `settings.json` conforme aprende quais permissions você usa muito
- Apague skills que não usa (não tem razão pra carregar 15 se você só usa 3)

---

## Suporte

Encontrou bug? Quer adicionar skill ao kit? Abre uma issue ou PR neste repo.

---

## Licença

MIT — fork à vontade, use comercialmente, adapte.

Empacotado com carinho pela [Daniela Okada](https://github.com/agencia-digd) · [dig.D](https://digd.com.br)
