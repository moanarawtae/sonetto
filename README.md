# sonetto

Sonetto é um player de música local para desktop, inspirado na fluidez de apps modernos sem depender de serviços externos. O projeto utiliza Electron, React, TypeScript e Tailwind CSS para entregar uma experiência consistente em Windows, macOS e Linux.

## Principais funcionalidades (M1)

- Estrutura Electron com processos `main`, `preload` e `renderer` isolados.
- Interface inicial com layout semelhante ao Spotify, porém com identidade própria.
- Barra "Agora tocando" com controles de reprodução, volume, shuffle e repeat.
- Motor de áudio baseado em `HTMLAudioElement`, controlado por Zustand.
- Suporte a seleção de arquivos de áudio locais (mp3 obrigatório, outros formatos best-effort).
- Alternância entre tema claro/escuro persistindo via Electron `nativeTheme`.

## Pré-requisitos

- Node.js 20 ou superior
- npm 9 ou superior

## Instalação

```bash
npm install
```

## Executando em desenvolvimento

```bash
npm run dev
```

Esse comando inicia o Vite com hot reload para o renderer e observa mudanças nos processos `main` e `preload`.

### Erro "exports is not defined in ES module scope"

Se durante `npm run dev` o Electron encerrar com a mensagem acima, verifique se o arquivo `package.json` contém `"type": "commonjs"`. Esse campo garante que o Node trate os bundles gerados em `dist/main` e `dist/preload` como CommonJS, disponibilizando as variáveis `exports` e `require` esperadas pelo código compilado. Após ajustar o arquivo, execute `npm run clean && npm run dev` para regenerar a saída em `dist/`.

## Build de produção

```bash
npm run build
npm run dist
```

O primeiro comando gera os artefatos de renderer, main e preload dentro de `dist/`. O segundo empacota o aplicativo com o `electron-builder`.

## Testes

- `npm run test` – testes unitários com Vitest (a serem implementados nos próximos marcos).
- `npm run e2e` – testes end-to-end com Playwright (placeholder).
- `npm run lint` – validação de linting com ESLint + TypeScript.

## Estrutura de pastas

```
.
├── build/                # Recursos para empacotamento (futuros)
├── dist/                 # Saída de build (gerado)
├── src/
│   ├── main/             # Processo principal do Electron
│   ├── preload/          # Context bridge seguro exposto à UI
│   └── renderer/         # Aplicação React + Zustand + Tailwind
├── index.html            # Entrada do Vite
└── README.md
```

## Próximos passos

1. Implementar scanner de biblioteca com SQLite para indexar faixas e metadados.
2. Construir listagens de artistas/álbuns com virtualização e busca unificada.
3. Adicionar gerenciamento de playlists, fila e drag-and-drop.
4. Integrar configurações avançadas, atalhos globais e testes automatizados.
5. Preparar instaladores para as três plataformas alvo.

## Licença

Este projeto é distribuído sob a licença MIT. Veja o arquivo `LICENSE` (a ser adicionado) para mais detalhes.
