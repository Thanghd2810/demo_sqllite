import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/services/sqlite/sqlite.dart';

final splashRepositoryProvider = Provider(
  (ref) => SplashRepository(dbHelper: ref.read(dbHelperProvider)),
);

class SplashRepository {
  SplashRepository({required DBHelper dbHelper}) : _dbHelper = dbHelper;

  final DBHelper _dbHelper;

  Future<void> initialApp() async {
    await _dbHelper.ensureInitialized();
  }
}
