import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/user_settings.dart';
import '../local/app_database.dart';
import '../remote/supabase_service.dart';

class SettingsRepository {
  SettingsRepository(this._db, this._supabase);

  final AppDatabase _db;
  final SupabaseService _supabase;

  Future<UserSettings?> loadLocal() => _db.loadSettings();

  Future<void> saveLocal(UserSettings settings) => _db.saveSettings(settings);

  Future<UserSettings?> fetchRemote() async {
    final result = await _supabase.client.from('settings').select().maybeSingle();
    if (result == null) return null;
    return UserSettings.fromJson(result as Map<String, dynamic>);
  }

  Future<void> upsertRemote(UserSettings settings) async {
    await _supabase.client.from('settings').upsert(settings.toJson());
  }
}

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final supabase = ref.watch(supabaseServiceProvider);
  return SettingsRepository(db, supabase);
});
