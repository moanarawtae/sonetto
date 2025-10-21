# sonetto 1.0.0

Sonetto é um player de música local multiplataforma inspirado nas melhores experiências de streaming, mas totalmente offline. A versão 1.0 inclui biblioteca com varredura de pastas, fila com shuffle/repeat, playlists persistidas em SQLite, tema claro/escuro, atalhos de teclado e interface responsiva construída em React + Tailwind.

## Stack

- **Electron 32** para empacotamento desktop (Windows, macOS, Linux).
- **React 18 + Vite 7 + Tailwind CSS 3** no renderer.
- **Zustand 5** para estados globais (player, biblioteca, preferências).
- **better-sqlite3 12** para banco local (`tracks`, `artists`, `albums`, `playlists`, `folders`).
- **music-metadata 11** para leitura de tags ID3, capas embutidas e duração.
- **chokidar 3** para monitoramento em tempo real das pastas indexadas.

## Pré-requisitos

- Node.js **>= 20.11.0**
- npm **>= 10.0.0**
- Ambiente com acesso ao sistema de arquivos das pastas de música.

## Instalação de dependências

```bash
npm install
```

Esse comando prepara o ambiente instalando todas as dependências necessárias (Electron, ferramentas de build, tipos TypeScript e bibliotecas de UI).

## Manual passo a passo – Iniciando o Sonetto 1.0

1. **Instalar dependências** – `npm install` (somente na primeira vez ou após atualizar `package.json`).
2. **Compilar e iniciar em desenvolvimento** – `npm run dev`.
   - O Vite sobe em `http://localhost:5173` para o renderer.
   - Os processos `main` e `preload` são observados com `tsc --watch`.
   - O Electron abre automaticamente após a compilação inicial.
3. **Adicionar pastas de música**
   - Clique em **“Adicionar pasta”** na barra superior ou abra **Configurações > Selecionar pastas**.
   - Selecione uma ou mais pastas contendo arquivos `.mp3`, `.m4a/.aac`, `.ogg`, `.wav` ou `.flac`.
   - O Sonetto inicia o scanner imediatamente (barra de progresso exibida no painel “Início”).
4. **Acompanhar o scan**
   - O painel **Início** mostra quantas faixas, artistas, álbuns e playlists já existem.
   - Durante a varredura, um cartão informa o arquivo atual e a porcentagem processada.
   - O scanner lê metadados, detecta capas (embutidas ou `cover.jpg/png`) e registra duplicatas por caminho.
5. **Explorar a biblioteca**
   - **Faixas**: lista virtualizada com ordenação e busca instantânea.
   - **Álbuns / Artistas**: grids responsivos com cartões.
   - **Playlists**: painel com botões de reprodução direta (em 1.0 apenas leitura; criação via scanner/placeholder).
6. **Reproduzir músicas**
   - Clique em qualquer faixa para carregar a fila a partir daquele ponto.
   - A barra **Agora tocando** exibe título, artista, progresso (scrub visual), controles de shuffle/repeat, volume e botão de expansão (reservado para futuras letras/fila detalhada).
7. **Atalhos de teclado** (janela ativa):
   - **Espaço** – play/pause
   - **Ctrl/Cmd + →** – próxima faixa
   - **Ctrl/Cmd + ←** – faixa anterior
   - **Alt + → / Alt + ←** – pular ±5s
   - **Ctrl/Cmd + ↑ / ↓** – volume ±5%
   - **Ctrl/Cmd + F** – focar busca
   - **Ctrl/Cmd + L** – focar biblioteca
8. **Gerenciar configurações**
   - Defina tema `Claro`, `Escuro` ou `Sistema` (persistido em `settings.json`).
   - Ative a ocultação de formatos não suportados pelo runtime.
   - Reexecute o scanner manualmente com **“Reescanear agora”**.
9. **Encerrar desenvolvimento**
   - Pressione `Ctrl+C` no terminal que roda `npm run dev`.

## Scripts úteis

| Script | Descrição |
| ------ | --------- |
| `npm run dev` | Compila main/preload, inicia Vite e abre o Electron em modo desenvolvimento. |
| `npm run build` | Gera bundles de renderer (`vite build`), main e preload (`tsc`). |
| `npm run dist` | Empacota instaladores com electron-builder (AppImage, dmg, nsis). |
| `npm run lint` | Executa ESLint com configuração flat (Node + Browser). |
| `npm run typecheck` | Verificação estrita do TypeScript sem emitir arquivos. |
| `npm run clean` | Remove diretório `dist/` e cache do Vite. |
| `npm run test` | Placeholder para testes unitários (Vitest). |
| `npm run e2e` | Placeholder para Playwright. |

## Arquitetura

```
src/
├── common/              # Constantes e tipos compartilhados entre processos
├── main/                # Processo principal (janela, banco, IPC, watcher)
│   ├── ipc/             # Registradores de canais IPC
│   ├── services/        # Banco, scanner, logger, watchers, settings
│   └── index.cts        # Bootstrap do Electron
├── preload/             # Context bridge seguro exposto ao renderer
│   └── index.cts
└── renderer/            # Aplicação React
    ├── components/      # Barra agora tocando, grids, tabelas
    ├── hooks/           # Tema, atalhos de teclado
    ├── pages/           # Início, Faixas, Álbuns, Artistas, Playlists, Configurações
    ├── state/           # Stores Zustand (player, biblioteca, settings)
    ├── styles/          # Tailwind
    └── utils/           # Helpers (ex: formatTime)
```

## Banco de dados

O banco SQLite é criado em `app.getPath('userData')/library.db` com as tabelas:

- `tracks` (metadados, duração, formato, relação com `folders`)
- `artists`, `albums`
- `playlists`, `playlist_tracks`
- `folders` (pastas monitoradas)

As capas extraídas são armazenadas em `userData/covers/<hash>.(jpg|png)` e o hash é referenciado na tabela `tracks`.

## Troubleshooting

- **Nenhum som ao reproduzir:** verifique a aba Configurações > “Ocultar formatos não suportados”; o preload detecta suporte via `HTMLAudioElement.canPlayType` e exibe aviso se o formato não estiver disponível.
- **Scanner demora em bibliotecas grandes:** o processo roda de forma incremental; mantenha a janela ativa para acompanhar o progresso. Pastas são monitoradas pelo `chokidar` e atualizações incrementais são disparadas automaticamente.
- **Erro “exports is not defined”:** confirme `"type": "commonjs"` no `package.json` e recompile (`npm run clean && npm run dev`).
- **Empacotamento falha por dependências nativas:** assegure-se de estar usando Node 20+ e ferramentas de build adequadas (Python 3 + ferramentas nativas específicas da plataforma).

## Licença

Projeto licenciado sob **MIT**. Contribuições e melhorias são bem-vindas!
