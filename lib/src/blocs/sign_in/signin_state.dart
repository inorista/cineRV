part of 'signin_cubit.dart';

enum SignInStatus { init, loading, finished, failed }

class SigninState extends Equatable {
  final signInStatus;
  const SigninState({this.signInStatus = SignInStatus.init});

  @override
  List<Object> get props => [signInStatus];
}
