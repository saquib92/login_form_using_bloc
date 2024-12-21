import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequest);
  }

  // @override
  // void onChange(Change<AuthState> change) {
  //   super.onChange(change);
  //   debugPrint('AuthBloc - Change - $change');
  // }

  // @override
  // void onTransition(Transition<AuthEvent, AuthState> transition) {
  //   super.onTransition(transition);
  //   debugPrint('AuthBloc - Transition - $transition');
  // }

  void _onAuthLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final email = event.email;
      final password = event.password;

      if (password.length < 6) {
        return emit(AuthFailure('Password cannot be less than 6 characters!'));
      }
      await Future.delayed(
        const Duration(seconds: 1),
        () {
          return emit(AuthSuccess(
            uid: '$email-$password',
          ));
        },
      );
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void _onAuthLogoutRequest(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await Future.delayed(
        const Duration(seconds: 1),
        () {
          return emit(AuthInitial());
        },
      );
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
