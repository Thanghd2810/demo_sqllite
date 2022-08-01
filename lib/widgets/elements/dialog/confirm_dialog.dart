import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sky_food/core/utils/utils.dart';

import '../../../../core/const/constants.dart';
import '../../../../route/router.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/elements/text_view.dart';

Future<bool?> showConfirmDialog(
  BuildContext context, {
  required String messages,
}) {
  return showDialog<bool>(
    context: context,
    builder: (_) {
      return _ConfirmDeleteDialog(
        messages: messages,
      );
    },
  );
}

class _ConfirmDeleteDialog extends HookWidget {
  const _ConfirmDeleteDialog({
    Key? key,
    required this.messages,
  }) : super(key: key);

  final String messages;

  @override
  Widget build(BuildContext context) {
    final Widget confirmButton = _buildBtnAction(
      text: 'Xác nhận',
      onPressed: () {
        AppRouter().pop<bool>(true);
      },
    );

    final Widget cancelButton = _buildBtnAction(
      text: 'Huỷ',
      fontColor: AppColors.red,
      onPressed: () {
        AppRouter().pop<bool>(false);
      },
    );

    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(vertical: 3.w, horizontal: 5.h),
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: kDefaultFatPadding,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      actions: [
        cancelButton,
        confirmButton,
      ],
      content: SizedBox(
        height: 60,
        child: Center(
          child: TextView(
            messages,
            fontColor: AppColors.black,
            fontSize: Responsive.isMobile ? FontSize.xLarge : FontSize.massive,
            maxLines: 2,
          ),
        ),
      ),
    );
  }

  TextButton _buildBtnAction({
    required String text,
    required VoidCallback onPressed,
    Color? fontColor,
  }) {
    return TextButton(
      child: TextView(
        text,
        fontColor: fontColor ?? AppColors.skyBlue,
        fontSize: Responsive.isMobile ? FontSize.large : FontSize.xLarge,
        fontWeight: FontWeight.bold,
      ),
      onPressed: onPressed,
    );
  }
}
