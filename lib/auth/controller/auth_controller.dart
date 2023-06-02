import 'package:appwrite/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repo/auth_repo.dart';
part 'auth_controller.g.dart';
// final _authControllerProvider =
//     AsyncNotifierProvider<AuthController, User?>(() => AuthController(ref));

// class AuthController extends AsyncNotifier<User?> {}

@riverpod
class AuthController extends _$AuthController {
  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncValue.loading();

    await ref
        .read(AuthRepo.provider)
        .signInWithEmailAndPassword(email, password);

    state = AsyncValue.data(await ref.read(AuthRepo.provider).currentUser());
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required String name}) async {
    state = const AsyncValue.loading();

    await ref
// ignore: avoid_manual_providers_as_generated_provider_dependency
        .read(AuthRepo.provider)
        .signUpWithEmailAndPassword(email, password, name);

    state = AsyncValue.data(await ref.read(AuthRepo.provider).currentUser());
  }

  @override
  FutureOr<User?> build() async {
    return await ref.read(AuthRepo.provider).currentUser();
  }
}
