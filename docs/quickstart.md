# sonetto quickstart

## preparação
- instale o Flutter 3.22 ou superior.
- execute `flutter pub get` para baixar dependências.
- duplique `.env.example` para `.env` e preencha:
  - `SUPABASE_URL=https://SEU-PROJETO.supabase.co`
  - `SUPABASE_ANON_KEY=chave_anon_publica`
  - `SPOTIFY_CLIENT_ID=sua_spotify_client_id`
  - `SPOTIFY_CLIENT_SECRET=sua_spotify_client_secret`
- nunca commit o arquivo `.env`; ele já está listado no `.gitignore`.
- rode `flutter pub run build_runner build --delete-conflicting-outputs` para gerar os arquivos `freezed` e `drift`.

## configuração supabase
- no painel Supabase, crie um projeto e copie `supabase_url` e `anon_key` para o `.env`.
- abra o editor sql e rode o conteúdo de `supabase/schema.sql`.
- habilite realtime nas tabelas `tracks`, `playlists`, `playlist_items` e `settings`.

## execução
- macos: `flutter run -d macos`.
- linux (x86_64): `flutter run -d linux`.
- ios: abra `ios/Runner.xcworkspace` no Xcode, selecione um iphone registrado, ajuste a assinatura com o seu Apple ID pessoal e execute.

## build
ainda em desenvolvimento pessoal, recomenda-se manter o app em modo debug. para compilar versões release, use:
- macos: `flutter build macos`.
- linux: `flutter build linux`.
- ios: `flutter build ios` (exige conta Apple e dispositivo registrado).

## problemas comuns
- *erro de env*: confirme que `.env` existe apenas localmente, está listado em `.gitignore` e contém as chaves corretas.
- *build_runner não encontra geradores*: rode `flutter pub get` antes de `build_runner`.
- *falha de login*: confira se o usuário foi criado via Supabase Auth e se o e-mail foi confirmado.
