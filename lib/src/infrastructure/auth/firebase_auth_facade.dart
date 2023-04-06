import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:holla_bella/src/domain/auth/auth_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:holla_bella/src/domain/auth/i_auth_facade.dart';
import 'package:holla_bella/src/domain/auth/value_objects.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:holla_bella/src/domain/core/value_objects.dart';
import 'package:holla_bella/src/domain/auth/user.dart' as _U;

@LazySingleton(as: IAuthFacade)
class FirebaseAuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthFacade(this._firebaseAuth, this._googleSignIn);

  @override
  Future<Option<_U.User>> getSignedInUser() async {
    return some(
        _U.User(id: UniqueId.fromUniqueString(_firebaseAuth.currentUser!.uid)));
  }

  @override
  Future<void> signOut() async {
    Future.wait([_googleSignIn.signOut(), _firebaseAuth.signOut()]);
  }

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAdress emailAddress,
    required Password password,
  }) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailAddressStr, password: passwordStr);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential' ||
          e.code == 'email-already-in-use') {
        return left(const AuthFailure.emailAlreadyInUse());
      } else {
        return left(const AuthFailure.serverError());
      }
    } catch (e) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAdress emailAddress,
    required Password password,
  }) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: emailAddressStr, password: passwordStr);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'user-not-found') {
        return left(const AuthFailure.invalidCredentials());
      } else {
        return left(const AuthFailure.serverError());
      }
    } catch (e) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(const AuthFailure.cancelledByUser());
      }

      final googleAuthentication = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );

      await _firebaseAuth.signInWithCredential(authCredential);
      return right(unit);
    } catch (e) {
      print(e);
      return left(const AuthFailure.serverError());
    }
  }
}
