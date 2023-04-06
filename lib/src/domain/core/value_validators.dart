import 'package:dartz/dartz.dart';
import 'package:holla_bella/src/domain/core/failures.dart';

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  // Maybe not the most robust way of email validation but it's good enough
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  }

  return left(ValueFailure.invalidEmail(failedValue: input));
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  // Maybe not the most robust way of email validation but it's good enough

  if (input.length >= 6) {
    return right(input);
  }

  return left(ValueFailure.shortPassword(failedValue: input));
}

Either<ValueFailure<String>, String> validateUsername(String input) {
  // Maybe not the most robust way of email validation but it's good enough

  if (input.length >= 3) {
    return right(input);
  }

  return left(ValueFailure.shortUsername(failedValue: input));
}
