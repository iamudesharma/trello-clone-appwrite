import 'dart:math';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

import '../../dependency/repository_exception.dart';

abstract class _IAuthReop {
  Future signInWithEmailAndPassword(String email, String password);
  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String name);
  Future signOut();
  Future sendPasswordResetEmail(String email);
  Future signInWithGoogle();
  Future signInWithFacebook();
  Future signInWithApple();
  Future<User?> currentUser();
}

class AuthRepo with RepositoryExceptionMixin implements _IAuthReop {
  final Account account;

  AuthRepo(this.account);
  @override
  Future sendPasswordResetEmail(String email) {
    // TODO: implement sendPasswordResetEmail
    throw UnimplementedError();
  }

  @override
  Future signInWithApple() {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  Future signInWithEmailAndPassword(String email, String password) async {
    await exceptionHandler(
        account.createEmailSession(email: email, password: password));
  }

  @override
  Future signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String name) async {
    return await exceptionHandler(account.create(
        userId: ID.unique(), email: email, password: password, name: name));
  }

  @override
  Future<User?> currentUser() async {
    return exceptionHandler(account.get());
  }
}
