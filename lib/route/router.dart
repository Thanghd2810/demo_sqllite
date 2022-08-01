library router;

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/admin/product/add/admin_add_product_page.dart';
import '../features/admin/product/show/admin_product_page.dart';
import '../features/admin/product/update/admin_product_update_page.dart';
import '../features/admin/setting/admin_setting_menu_page.dart';
import '../features/admin/setting/admin_setting_page.dart';
import '../features/admin/supplier/admin_supplier_page.dart';
import '../features/home/home_page.dart';
import '../features/order/modules/order_pdf_page.dart';
import '../features/order/order_detail_page.dart';
import '../features/order/order_page.dart';
import '../features/product_details/product_details_page.dart';
import '../features/root/root_page.dart';
import '../features/splash/splash_page.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';

part 'router.gr.dart';

part 'router_observer.dart';

final routerProvider = Provider<AppRouter>((_) => AppRouter());

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: SplashPage,
      initial: true,
    ),
    AutoRoute(
      path: '/root',
      page: RootPage,
      children: <AutoRoute>[
        AutoRoute(
          path: 'home',
          page: HomePage,
        ),
        AutoRoute(
          path: 'order',
          page: OrderPage,
        ),
        AutoRoute(
          path: 'admin',
          page: AdminSettingPage,
        ),
      ],
    ),
    AutoRoute(
      path: '/product_details',
      page: ProductDetailsPage,
    ),
    AutoRoute(
      path: '/order_detail',
      page: OrderDetailPage,
    ),
    AutoRoute(
      path: '/admin_add_product',
      page: AdminAddProductPage,
    ),
    AutoRoute(
      path: '/admin_menu',
      page: AdminSettingMenuPage,
    ),
    AutoRoute(
      path: '/admin_product',
      page: AdminProductPage,
    ),
    AutoRoute(
      path: '/admin_supplier',
      page: AdminSupplierPage,
    ),
    AutoRoute(
      path: '/admin_product_update',
      page: AdminProductUpdatePage,
    ),
    AutoRoute(
      path: '/order_export_pdf',
      page: OrderPDFPage,
    ),
  ],
)
class AppRouter extends _$AppRouter {
  AppRouter._();

  static AppRouter? _instance;

  factory AppRouter() => _instance ??= AppRouter._();
}
