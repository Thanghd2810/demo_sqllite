library pdf_service;

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sky_food/core/utils/extensions/date_time.dart';
import 'package:sky_food/models/order_model.dart';

import '../../../models/supplier_with_order.dart';

part 'pdf_helper.dart';
