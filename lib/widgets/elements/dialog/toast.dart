import 'package:flutter/cupertino.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../theme/theme.dart';

TextStyle _defaultTextStyleToast = const TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: FontSize.small,
  color: FontColor.white,
);

class ShowToast {
  ShowToast.warning(BuildContext context, {String? message}) {
    showTopSnackBar(
      context,
      CustomSnackBar.info(
        message: "Cảnh báo" + (message ?? ""),
        textStyle: _defaultTextStyleToast,
        backgroundColor: AppColors.orange,
      ),
      displayDuration: const Duration(seconds: 0),
    );
  }

  ShowToast.info(BuildContext context, {required String message}) {
    showTopSnackBar(
      context,
      CustomSnackBar.info(
        message: message,
        textStyle: _defaultTextStyleToast,
        backgroundColor: AppColors.skyBlue,
      ),
      displayDuration: const Duration(seconds: 0),
    );
  }

  ShowToast.success(BuildContext context, {String? message}) {
    showTopSnackBar(
      context,
      CustomSnackBar.success(
        backgroundColor: AppColors.green,
        message: message ?? "Thành công",
        textStyle: _defaultTextStyleToast,
      ),
      displayDuration: const Duration(seconds: 0),
    );
  }

  ShowToast.error(BuildContext context, {String? message}) {
    showTopSnackBar(
      context,
      CustomSnackBar.error(
        message: message ?? "Thất bại",
        textStyle: _defaultTextStyleToast,
      ),
      displayDuration: const Duration(seconds: 0),
    );
  }
}
