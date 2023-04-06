import 'package:dartz/dartz.dart';
import 'package:holla_bella/src/domain/core/failures.dart';
import 'package:holla_bella/src/domain/core/value_objects.dart';
import 'package:holla_bella/src/domain/core/value_validators.dart';

class EmailAdress extends ValueObject {
  @override
  final Either<ValueFailure<String>, String> value;

  factory EmailAdress(String input) {
    return EmailAdress._(validateEmailAddress(input));
  }

  const EmailAdress._(this.value);
}

class Password extends ValueObject {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Password(String input) {
    return Password._(validatePassword(input));
  }

  const Password._(this.value);
}

class Username extends ValueObject {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Username(String input) {
    return Username._(validateUsername(input));
  }

  const Username._(this.value);
}
