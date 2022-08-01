import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../core/const/constants.dart';
import '../../theme/theme.dart';

typedef SelectBoxBuilder<T> = Widget Function(T data);

class SelectBox<T> extends HookWidget {
  const SelectBox({
    Key? key,
    required this.onChanged,
    required this.itemsSrc,
    required this.value,
    required this.itemBuilder,
  }) : super(key: key);

  final List<T> itemsSrc;
  final T value;
  final SelectBoxBuilder<T> itemBuilder;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        onChanged: (value) {
          if (value == null) return;

          onChanged(value);
        },
        items: itemsSrc.map<DropdownMenuItem<T>>((T data) {
          return DropdownMenuItem<T>(value: data, child: itemBuilder(data));
        }).toList(),
        value: value,
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
        iconSize: 30,
        buttonPadding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
        ),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.skyBlue,
          ),
        ),
        itemHeight: 52,
        dropdownMaxHeight: 300,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.skyBlue,
          ),
          color: AppColors.white,
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
      ),
    );
  }
}
