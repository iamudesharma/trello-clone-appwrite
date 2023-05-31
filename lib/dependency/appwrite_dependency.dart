import 'package:appwrite/appwrite.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/appwrite_config.dart';

final class AppWriteDependency {
  static Provider<Client> get client => _clientProvider;
  static Provider<Account> get account => _accountProvider;
  static Provider<Databases> get database => _databaseProvider;
}

final _clientProvider = Provider<Client>((ref) {
  return Client()
      .setEndpoint(AppWriteConfig.endpoint)
      .setProject(AppWriteConfig.project)
      .setSelfSigned(status: AppWriteConfig.selfSigned);
});

final _accountProvider = Provider<Account>((ref) {
  return Account(ref.watch(_clientProvider));
});

final _databaseProvider = Provider<Databases>((ref) {
  return Databases(ref.watch(_clientProvider));
});
