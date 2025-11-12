# Sonetto

Sonetto é um aplicativo pessoal de música com sincronização usando Supabase, download de faixas via YouTube e metadados via Spotify.

## Segurança e boas práticas
- Nunca publique o arquivo `.env` nem chaves reais; o arquivo já está no `.gitignore`. Use `.env.example` como base e mantenha um `.env` apenas local.
- Se você já expôs alguma chave (Supabase ou Spotify), gere novas credenciais imediatamente no painel correspondente.
- Para builds distribuídos, mova as chaves para um backend seguro ou utilize variáveis de ambiente em tempo de execução.

## Quickstart
1. Instale Flutter 3.22 ou superior e execute `flutter pub get`.
2. Copie `cp .env.example .env` e preencha os valores locais. **Não** commit este arquivo. Para habilitar o scrobble do Last.fm, defina `LASTFM_API_KEY` e `LASTFM_API_SECRET`.
3. Execute `flutter pub run build_runner build --delete-conflicting-outputs` para gerar os arquivos `freezed` e `drift`.
4. Configure o Supabase: crie um projeto, copie `SUPABASE_URL` e `SUPABASE_ANON_KEY`, rode `supabase/schema.sql` e habilite realtime nas tabelas `tracks`, `playlists`, `playlist_items` e `settings`.
5. Rode o app: `flutter run -d macos`, `flutter run -d linux`, ou abra o projeto iOS no Xcode (`ios/Runner.xcworkspace`).

### Builds
- macOS: `flutter build macos`
- Linux: `flutter build linux`
- iOS: `flutter build ios` (exige conta Apple e dispositivo registrado)

## Troubleshooting
- **Erro de env**: confirme que `.env` existe localmente e contém chaves válidas; o arquivo não deve ir para o controle de versão.
- **build_runner não encontra geradores**: rode `flutter pub get` antes de `build_runner`.
- **Falha de login**: garanta que o usuário foi criado via Supabase Auth e confirmou o e-mail.
