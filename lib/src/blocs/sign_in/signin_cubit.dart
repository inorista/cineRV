import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit() : super(const SigninState(signInStatus: SignInStatus.init));

  Future<void> SignIn() async {
    emit(const SigninState(signInStatus: SignInStatus.loading));
  }
}
