import 'package:dartz/dartz.dart';
import 'package:holla_bella/src/domain/auth/auth_failure.dart';
import 'package:holla_bella/src/domain/auth/user.dart';
import 'package:holla_bella/src/domain/auth/value_objects.dart';

abstract class IAuthFacade {
  Future<Option<User>> getSignedInUser();
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAdress emailAddress,
    required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAdress emailAddress,
    required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithGoogle();
  Future<void> signOut();
}
