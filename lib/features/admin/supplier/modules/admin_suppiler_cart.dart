import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sky_food/core/const/constants.dart';
import 'package:sky_food/models/supplier_model.dart';
import 'package:sky_food/widgets/elements/text_view.dart';

import '../../../../core/utils/utils.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/elements/assets_gen/assets.gen.dart';
import '../../../../widgets/elements/dialog/confirm_dialog.dart';
import '../admin_supplier_view_model.dart';
import 'admin_supplier_update_dialog.dart';

class AdminSupplierCart extends HookConsumerWidget {
  const AdminSupplierCart({
    Key? key,
    required this.supplier,
  }) : super(key: key);

  final SupplierModel supplier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminSupplierVM = ref.read(adminSupplierViewModelProvider);

    return Slidable(
      key: ValueKey(supplier),
      endActionPane: ActionPane(
        dismissible: DismissiblePane(
          onDismissed: () async {},
          confirmDismiss: () async {
            final isDelete = await showConfirmDialog(
                  context,
                  messages: "Bạn có muốn xoá không?",
                ) ??
                false;

            if (isDelete) {
              adminSupplierVM.remove(supplier);
            }

            return isDelete;
          },
          closeOnCancel: true,
        ),
        motion: const ScrollMotion(),
        children: [
          CustomSlidableAction(
            onPressed: (_) {
              showSupplierUpdateDialog(context, supplier: supplier);
            },
            backgroundColor: AppColors.skyBlue[200]!,
            child: Row(
              children: [
                Expanded(
                    child: Assets.images.icEdit.image(
                  height: Responsive.isMobile ? 25 : 50,
                )),
              ],
            ),
          ),
          CustomSlidableAction(
            onPressed: (_) async {
              final isDelete = await showConfirmDialog(
                    context,
                    messages: "Bạn có muốn xoá không?",
                  ) ??
                  false;

              if (isDelete) {
                adminSupplierVM.remove(supplier);
              }
            },
            backgroundColor: AppColors.pink,
            child: Row(
              children: [
                Expanded(
                    child: Assets.images.icTrash.image(
                  height: Responsive.isMobile ? 25 : 50,
                )),
              ],
            ),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultExThinPadding,
                  vertical: kDefaultPadding,
                ),
                child: ListTile(
                  title: TextView(
                    supplier.name,
                    fontSize:
                        Responsive.isMobile ? FontSize.large : FontSize.massive,
                    fontWeight: FontWeight.bold,
                  ),
                  trailing: Transform.scale(
                    scale: Responsive.isMobile ? 1 : 1.8,
                    child: Checkbox(
                      activeColor: AppColors.skyBlue,
                      shape: const CircleBorder(),
                      tristate: false,
                      value: supplier.isShow,
                      splashRadius: 20,
                      onChanged: (bool? value) {
                        adminSupplierVM.isShow = value ?? false;
                        adminSupplierVM.updateStatus(supplier);
                      },
                    ),
                  ),
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
