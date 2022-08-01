import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sky_food/core/utils/extensions/date_time.dart';

import '../../../theme/theme.dart';

class OrderPDFPage extends HookConsumerWidget {
  const OrderPDFPage({
    Key? key,
    required this.file,
  }) : super(key: key);

  final File file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = basename(file.path);

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: PDFView(
        filePath: file.path,
        autoSpacing: false,
        pageSnap: false,
        pageFling: false,
      ),
      floatingActionButton: IconButton(
        onPressed: () async {
          await Share.shareFiles([file.path],
              text: name,
              subject:
                  "Đặt cơm ngày" + DateTime.now().formatddMMYYYY().toString());
        },
        icon: const Icon(
          Icons.share_rounded,
          size: 40,
          color: AppColors.skyBlue,
        ),
      ),
    );
  }
}
