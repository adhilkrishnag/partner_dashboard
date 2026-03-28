import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:partner_dashboard/services/api_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_authEventHandler);
  }

  Future<void> _authEventHandler(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await ApiService.login(
        partnerKey: event.partnerKey,
        email: event.email,
        password: event.password,
      );
      if (response) {
        emit(AuthSuccess());
      } else {
        emit(
          const AuthFailure(
            'Login failed. Please check your credentials and try again.',
          ),
        );
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
