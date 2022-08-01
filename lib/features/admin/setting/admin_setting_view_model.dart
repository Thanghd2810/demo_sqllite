import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/core/view_model/view_model.dart';

import '../../../core/utils/utils.dart';
import '../../../route/router.dart';

const String _passDefault = 'skydart';

final adminSettingVMProvider =
    ChangeNotifierProvider.autoDispose<AdminSettingViewModel>((ref) {
  return AdminSettingViewModel(ref.read);
});

class AdminSettingViewModel extends ViewModel {
  AdminSettingViewModel(Reader read) : super(read);

  final _debouncer = Debouncer(milliseconds: 300);

  String password = "";

  String _errorMes = "";
  String get errorMes => _errorMes;
  set errorMes(String error) {
    _errorMes = error;
    _debouncer.run(notifyListeners);
  }

  void verifyPass() {
    if (password != _passDefault) {
      errorMes = "Sai Mật khẩu vui lòng thử lại";
      return;
    }

    router.replace(const AdminSettingMenuRoute());
  }
}
