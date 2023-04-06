import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:holla_bella/src/domain/auth/auth_failure.dart';
import 'package:holla_bella/src/domain/auth/i_auth_facade.dart';
import 'package:holla_bella/src/domain/auth/value_objects.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';
part 'sign_in_form_bloc.freezed.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  SignInFormBloc(this._authFacade) : super(SignInFormState.initial()) {
    // ignore: void_checks
    on<SignInFormEvent>((event, emit) async {
      await event.map<FutureOr<void>>(emailChanged: (e) {
        emit(state.copyWith(
            emailAdress: EmailAdress(e.emailStr),
            authFailureOrSuccessOption: none()));
      }, passwordChanged: (e) {
        emit(state.copyWith(
            password: Password(e.passwordStr),
            authFailureOrSuccessOption: none()));
      }, signInWithEmailAndPasswordPressed: (e) async {
        Either<AuthFailure, Unit>? failureOrSuccess;

        final isEmailValid = state.emailAdress.isValid();
        final isPasswordValid = state.password.isValid();

        if (isEmailValid && isPasswordValid) {
          emit(state.copyWith(
              isSubmitting: true, authFailureOrSuccessOption: none()));

          failureOrSuccess = await _authFacade.signInWithEmailAndPassword(
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
