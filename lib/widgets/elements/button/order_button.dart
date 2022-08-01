import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';

import '../text_view.dart';
import 'button.dart';

class OrderButton extends HookWidget {
  const OrderButton(
    this.title, {
    Key? key,
    required this.onTap,
    this.buttonSize,
    required this.imgSrc,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final String imgSrc;
  final ButtonSize? buttonSize;

  @override
  Widget build(BuildContext context) {
    return Button(
      title,
      buttonSize: ButtonSize.large,
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(imgSrc),
          const SizedBox(width: 10),
          TextView(
            title,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
