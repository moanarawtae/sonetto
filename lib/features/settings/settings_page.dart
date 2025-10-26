import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_controller.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsControllerProvider);
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
