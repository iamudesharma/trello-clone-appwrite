import 'dart:math';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trello_clone_appwrite/dependency/appwrite_dependency.dart';

import '../../dependency/repository_exception.dart';

final _authRepoProvider = Provider<IAuthReop>((ref) {
  return AuthRepo(ref.watch(AppWriteDependency.account));
});

abstract class IAuthReop {
  Future<Session?> signInWithEmailAndPassword(String email, String password);
  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String name);
  Future signOut();
  Future sendPasswordResetEmail(String email);
  Future signInWithGoogle();
  Future signInWithFacebook();
  Future signInWithApple();
  Future<User?> currentUser();
}

class AuthRepo with RepositoryExceptionMixin implements IAuthReop {
  static Provider<IAuthReop> get provider => _authRepoProvider;
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
  Future<Session?> signInWithEmailAndPassword(String email, String password) async {
   return await exceptionHandler<Session>(
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
    return await exceptionHandler(Future.wait([
      account.create(
          userId: ID.unique(), email: email, password: password, name: name),
      currentUser(),
    ]));
  }

  @override
  Future<User?> currentUser() async {
    try {
      final user = account.get();

      print(user);

      return user;
    } catch (e) {
      return null;
    }
  }
}
