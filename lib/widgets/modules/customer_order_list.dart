import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sky_food/core/utils/utils.dart';

import '../../theme/theme.dart';
import '../elements/text_view.dart';

class CustomerOrderList extends HookWidget {
  const CustomerOrderList({
    Key? key,
    required this.customers,
  }) : super(key: key);

  final List<String> customers;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DataTable(
        columnSpacing: 15,
        columns: [
          _DataColumn(label: 'Tên người đặt'),
          _DataColumn(label: 'Team'),
          _DataColumn(label: Responsive.isMobile ? 'SL' : 'Số lượng'),
        ],
        rows: customers.map(
          (cus) {
            return DataRow(
              cells: <DataCell>[
                _DataCell(
                  title: cus.split('-').first,
                  width: 60.w,
                ),
                _DataCell(
                  title: cus.split('-')[1],
                  width: 10.w,
                ),
                _DataCell(
                  title: cus.split('-').last,
                  width: 5.w,
                ),
              ],
            );
          },
        ).toList(),
      ),
    );
  }
}

class _DataColumn extends DataColumn {
  _DataColumn({required String label})
      : super(
          label: TextView(
            label,
            defaultTextStyle: const TextStyle(fontStyle: FontStyle.italic),
            fontSize: Responsive.isMobile ? FontSize.large : FontSize.xLarge,
          ),
        );
}

class _DataCell extends DataCell {
  _DataCell({required String title, required double width})
      : super(
          SizedBox(
            width: width,
            child: TextView(title),
          ),
        );
}
