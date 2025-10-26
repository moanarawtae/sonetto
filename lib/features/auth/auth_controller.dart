import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/sync/sync_service.dart';

enum AuthStatusState { idle, loading, success, error }

class AuthState {
  const AuthState({required this.status, this.message});

  final AuthStatusState status;
  final String? message;

  AuthState copyWith({AuthStatusState? status, String? message}) =>
      AuthState(status: status ?? this.status, message: message ?? this.message);
}

class AuthController extends StateNotifier<AuthState> {
  AuthController(this._sync) : super(const AuthState(status: AuthStatusState.idle));

  final SyncService _sync;

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(status: AuthStatusState.loading, message: null);
    try {
      final status = await _sync.signIn(email, password);
      if (status == AuthStatus.signedIn) {
        state = state.copyWith(status: AuthStatusState.success);
      } else {
        state = state.copyWith(status: AuthStatusState.error, message: 'credenciais inválidas');
      }
    } catch (error) {
      state = state.copyWith(status: AuthStatusState.error, message: error.toString());
    }
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(ref.watch(syncServiceProvider));
});
