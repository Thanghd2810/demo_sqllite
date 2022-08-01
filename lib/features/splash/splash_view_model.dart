import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/repositories/splash_repository.dart';
import 'package:sky_food/route/router.dart';

import '../../core/view_model/view_model.dart';

final splashCtrlProvider = Provider.autoDispose<SplashViewModel>(
  (ref) => SplashViewModel(ref.read),
);

class SplashViewModel extends ViewModel {
  SplashViewModel(Reader read)
      : _read = read,
        super(read);

  final Reader _read;

  SplashRepository get splashRepo => _read(splashRepositoryProvider);

  Future<void> init() async {
    try {
      await splashRepo.initialApp();

      await Future.delayed(const Duration(seconds: 3), () {
        router.replace(const RootRoute());
      });
    } catch (e) {
      handleExceptions(e);
      throw Exception('There is a fatal error');
    }
  }
}
