import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


enum AuthStatus { signedOut, signedIn }

class SupabaseService {
  SupabaseService(this._client);

  final SupabaseClient _client;

  SupabaseClient get client => _client;

  Future<AuthStatus> signInWithPassword({required String email, required String password}) async {
    final response = await _client.auth.signInWithPassword(email: email, password: password);
    return response.session == null ? AuthStatus.signedOut : AuthStatus.signedIn;
  }

  Future<void> signOut() => _client.auth.signOut();

  Stream<AuthStatus> get authState => _client.auth.onAuthStateChange.map(
        (event) => event.session == null ? AuthStatus.signedOut : AuthStatus.signedIn,
      );

  RealtimeChannel subscribeTable(String table, {required String userId, void Function(PostgresChangePayload)? onChange}) {
    final channel = _client.channel('public:$table:user:$userId');
    channel.onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: table,
      filter: PostgresChangeFilter(type: PostgresChangeFilterType.eq, column: 'user_id', value: userId),
      callback: onChange,
    );
    channel.subscribe();
    return channel;
  }
}

final supabaseServiceProvider = Provider<SupabaseService>((ref) {
  final client = Supabase.instance.client;
  return SupabaseService(client);
});

final authStateProvider = StreamProvider<AuthStatus>((ref) {
  final service = ref.watch(supabaseServiceProvider);
  return service.authState;
});
