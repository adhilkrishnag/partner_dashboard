part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String partnerKey;
  final String email;
  final String password;

  const LoginRequested({
    required this.partnerKey,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [partnerKey, email, password];
}
