import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/integrations/lastfm_service.dart';
import 'settings_controller.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsControllerProvider);
    final lastFmService = ref.watch(lastFmServiceProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('configurações')),
      body: settingsAsync.when(
        data: (settings) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SwitchListTile(
              title: const Text('normalizar volume'),
              value: settings.normalizeVolume,
              onChanged: (value) => ref.read(settingsControllerProvider.notifier).toggleNormalize(value),
            ),
            ListTile(
              title: const Text('crossfade (ms)'),
              subtitle: Text('${settings.crossfadeMs} ms'),
              trailing: DropdownButton<int>(
                value: settings.crossfadeMs,
                items: const [0, 1000, 3000, 5000, 10000]
                    .map((value) => DropdownMenuItem(value: value, child: Text('$value')))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    ref.read(settingsControllerProvider.notifier).updateCrossfade(value);
                  }
                },
              ),
            ),
            const Divider(),
            if (!lastFmService.isConfigured)
              ListTile(
                title: const Text('Last.fm indisponível'),
                subtitle: const Text('Configure LASTFM_API_KEY e LASTFM_API_SECRET no .env para habilitar scrobble.'),
              )
            else ...[
                SwitchListTile(
                  title: const Text('scrobble no Last.fm'),
                  subtitle: Text(
                    settings.scrobbleToLastFm && (settings.lastFmUsername?.isNotEmpty ?? false)
                        ? 'Conectado como ${settings.lastFmUsername}'
                        : 'Envie suas audições para o Last.fm',
                  ),
                  value: settings.scrobbleToLastFm && (settings.lastFmSessionKey?.isNotEmpty ?? false),
                  onChanged: (value) async {
                    final controller = ref.read(settingsControllerProvider.notifier);
                    final scaffold = ScaffoldMessenger.of(context);
                    try {
                      if (value) {
                        if (settings.lastFmSessionKey?.isNotEmpty == true) {
                          await controller.enableLastFmScrobbling();
                        } else {
                          final credentials = await _LastFmCredentialsDialog.show(context);
                          if (credentials == null) return;
                          await controller.enableLastFmScrobbling(
                            username: credentials.username,
                            password: credentials.password,
                          );
                        }
                        scaffold.showSnackBar(const SnackBar(content: Text('Scrobble ativado')));
                      } else {
                        await controller.disableLastFmScrobbling();
                        scaffold.showSnackBar(const SnackBar(content: Text('Scrobble desativado')));
                      }
                    } catch (error) {
                      scaffold.showSnackBar(SnackBar(content: Text('Erro: $error')));
                    }
                  },
                ),
                if (settings.lastFmSessionKey?.isNotEmpty == true)
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                    child: FilledButton.tonalIcon(
                      onPressed: () async {
                        final controller = ref.read(settingsControllerProvider.notifier);
                        final scaffold = ScaffoldMessenger.of(context);
                        await controller.disconnectLastFm();
                        scaffold.showSnackBar(const SnackBar(content: Text('Last.fm desconectado')));
                      },
                      icon: const Icon(Icons.link_off),
                      label: const Text('Desconectar do Last.fm'),
                    ),
                  ),
              ],
            const Divider(),
            ElevatedButton.icon(
              onPressed: () => ref.read(settingsControllerProvider.notifier).signOut(),
              icon: const Icon(Icons.logout),
              label: const Text('sair'),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('erro: $error')),
      ),
    );
  }
}

class _LastFmCredentials {
  _LastFmCredentials(this.username, this.password);

  final String username;
  final String password;
}

class _LastFmCredentialsDialog extends StatefulWidget {
  const _LastFmCredentialsDialog();

  static Future<_LastFmCredentials?> show(BuildContext context) {
    return showDialog<_LastFmCredentials>(
      context: context,
      builder: (_) => const _LastFmCredentialsDialog(),
    );
  }

  @override
  State<_LastFmCredentialsDialog> createState() => _LastFmCredentialsDialogState();
}

class _LastFmCredentialsDialogState extends State<_LastFmCredentialsDialog> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Conectar Last.fm'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Usuário'),
            textCapitalization: TextCapitalization.none,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Senha'),
            obscureText: true,
          ),
          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('cancelar'),
        ),
        FilledButton(
          onPressed: () {
            final username = _usernameController.text.trim();
            final password = _passwordController.text.trim();
            if (username.isEmpty || password.isEmpty) {
              setState(() => _error = 'Preencha usuário e senha');
              return;
            }
            Navigator.of(context).pop(_LastFmCredentials(username, password));
          },
          child: const Text('conectar'),
        ),
      ],
    );
  }
}
