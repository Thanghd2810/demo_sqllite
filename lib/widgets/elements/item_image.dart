import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sky_food/core/utils/utils.dart';

class ItemImage extends HookWidget {
  final String imgSrc;
  const ItemImage({
    Key? key,
    required this.imgSrc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imgSrc,
      height: 25.w,
      width: double.infinity,
      fit: BoxFit.fill,
    );
  }
}
