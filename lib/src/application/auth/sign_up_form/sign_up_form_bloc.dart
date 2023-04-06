import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:holla_bella/src/domain/auth/auth_failure.dart';
import 'package:holla_bella/src/domain/auth/i_auth_facade.dart';
import 'package:holla_bella/src/domain/auth/value_objects.dart';

part 'sign_up_form_event.dart';
part 'sign_up_form_state.dart';
part 'sign_up_form_bloc.freezed.dart';

@injectable
class SignUpFormBloc extends Bloc<SignUpFormEvent, SignUpFormState> {
  final IAuthFacade _authFacade;

  SignUpFormBloc(this._authFacade) : super(SignUpFormState.initial()) {
    // ignore: void_checks
    on<SignUpFormEvent>((event, emit) async {
      await event.map<FutureOr<void>>(emailChanged: (e) {
        emit(state.copyWith(
            emailAdress: EmailAdress(e.emailStr),
            authFailureOrSuccessOption: none()));
      }, passwordChanged: (e) {
        emit(state.copyWith(
            password: Password(e.passwordStr),
            authFailureOrSuccessOption: none()));
      }, usernameChanged: (e) {
        emit(state.copyWith(
            username: Username(e.usernameStr),
            authFailureOrSuccessOption: none()));
      }, registerWithEmailAndPasswordPressed: (e) async {
        Either<AuthFailure, Unit>? failureOrSuccess;

        final isEmailValid = state.emailAdress.isValid();
        final isPasswordValid = state.password.isValid();

        if (isEmailValid && isPasswordValid) {
          emit(state.copyWith(
              isSubmitting: true, authFailureOrSuccessOption: none()));

          failureOrSuccess = await _authFacade.registerWithEmailAndPassword(
              emailAddress: state.emailAdress, password: state.password);
        }

        emit(state.copyWith(
            isSubmitting: false,
            showErrorMessages: true,
            authFailureOrSuccessOption: optionOf(failureOrSuccess)));
      }, signInWithGooglePressed: (e) async {
        emit(state.copyWith(
            isSubmitting: true, authFailureOrSuccessOption: none()));

        final failureOrSuccess = await _authFacade.signInWithGoogle();
        emit(state.copyWith(
            isSubmitting: false,
            authFailureOrSuccessOption: some(failureOrSuccess)));
      });
    });
  }
}
