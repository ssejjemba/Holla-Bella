part of 'sign_up_form_bloc.dart';

@freezed
class SignUpFormState with _$SignUpFormState {
  const factory SignUpFormState(
      {required EmailAdress emailAdress,
      required Password password,
      required Username username,
      required bool showErrorMessages,
      required bool isSubmitting,
      required Option<Either<AuthFailure, Unit>>
          authFailureOrSuccessOption}) = _SignUpFormState;

  factory SignUpFormState.initial() => SignUpFormState(
        emailAdress: EmailAdress(''),
        password: Password(''),
        username: Username(''),
        showErrorMessages: false,
        isSubmitting: false,
        authFailureOrSuccessOption: none(),
      );
}
