// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const SplashPage());
    },
    RootRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const RootPage());
    },
    ProductDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ProductDetailsRouteArgs>();
      return AdaptivePage<dynamic>(
          routeData: routeData,
          child: ProductDetailsPage(
              key: args.key,
              product: args.product,
              nameSupplier: args.nameSupplier));
    },
    OrderDetailRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<OrderDetailRouteArgs>(
          orElse: () => OrderDetailRouteArgs(
              order: queryParams.get('order'),
              supplierName: queryParams.optString('supplier_name')));
      return AdaptivePage<dynamic>(
          routeData: routeData,
          child: OrderDetailPage(
              key: args.key,
              order: args.order,
              supplierName: args.supplierName));
    },
    AdminAddProductRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const AdminAddProductPage());
    },
    AdminSettingMenuRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const AdminSettingMenuPage());
    },
    AdminProductRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const AdminProductPage());
    },
    AdminSupplierRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const AdminSupplierPage());
    },
    AdminProductUpdateRoute.name: (routeData) {
      final args = routeData.argsAs<AdminProductUpdateRouteArgs>();
      return AdaptivePage<dynamic>(
          routeData: routeData,
          child: AdminProductUpdatePage(key: args.key, product: args.product));
    },
    OrderPDFRoute.name: (routeData) {
      final args = routeData.argsAs<OrderPDFRouteArgs>();
      return AdaptivePage<dynamic>(
          routeData: routeData,
          child: OrderPDFPage(key: args.key, file: args.file));
    },
    HomeRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const HomePage());
    },
    OrderRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const OrderPage());
    },
    AdminSettingRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const AdminSettingPage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(SplashRoute.name, path: '/'),
        RouteConfig(RootRoute.name, path: '/root', children: [
          RouteConfig(HomeRoute.name, path: 'home', parent: RootRoute.name),
          RouteConfig(OrderRoute.name, path: 'order', parent: RootRoute.name),
          RouteConfig(AdminSettingRoute.name,
              path: 'admin', parent: RootRoute.name)
        ]),
        RouteConfig(ProductDetailsRoute.name, path: '/product_details'),
        RouteConfig(OrderDetailRoute.name, path: '/order_detail'),
        RouteConfig(AdminAddProductRoute.name, path: '/admin_add_product'),
        RouteConfig(AdminSettingMenuRoute.name, path: '/admin_menu'),
        RouteConfig(AdminProductRoute.name, path: '/admin_product'),
        RouteConfig(AdminSupplierRoute.name, path: '/admin_supplier'),
        RouteConfig(AdminProductUpdateRoute.name,
            path: '/admin_product_update'),
        RouteConfig(OrderPDFRoute.name, path: '/order_export_pdf')
      ];
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [RootPage]
class RootRoute extends PageRouteInfo<void> {
  const RootRoute({List<PageRouteInfo>? children})
      : super(RootRoute.name, path: '/root', initialChildren: children);

  static const String name = 'RootRoute';
}

/// generated route for
/// [ProductDetailsPage]
class ProductDetailsRoute extends PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute(
      {Key? key, required ProductModel product, required String nameSupplier})
      : super(ProductDetailsRoute.name,
            path: '/product_details',
            args: ProductDetailsRouteArgs(
                key: key, product: product, nameSupplier: nameSupplier));

  static const String name = 'ProductDetailsRoute';
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs(
      {this.key, required this.product, required this.nameSupplier});

  final Key? key;

  final ProductModel product;

  final String nameSupplier;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, product: $product, nameSupplier: $nameSupplier}';
  }
}

/// generated route for
/// [OrderDetailPage]
class OrderDetailRoute extends PageRouteInfo<OrderDetailRouteArgs> {
  OrderDetailRoute({Key? key, OrderModel? order, String? supplierName})
      : super(OrderDetailRoute.name,
            path: '/order_detail',
            args: OrderDetailRouteArgs(
                key: key, order: order, supplierName: supplierName),
            rawQueryParams: {'order': order, 'supplier_name': supplierName});

  static const String name = 'OrderDetailRoute';
}

class OrderDetailRouteArgs {
  const OrderDetailRouteArgs({this.key, this.order, this.supplierName});

  final Key? key;

  final OrderModel? order;

  final String? supplierName;

  @override
  String toString() {
    return 'OrderDetailRouteArgs{key: $key, order: $order, supplierName: $supplierName}';
  }
}

/// generated route for
/// [AdminAddProductPage]
class AdminAddProductRoute extends PageRouteInfo<void> {
  const AdminAddProductRoute()
      : super(AdminAddProductRoute.name, path: '/admin_add_product');

  static const String name = 'AdminAddProductRoute';
}

/// generated route for
/// [AdminSettingMenuPage]
class AdminSettingMenuRoute extends PageRouteInfo<void> {
  const AdminSettingMenuRoute()
      : super(AdminSettingMenuRoute.name, path: '/admin_menu');

  static const String name = 'AdminSettingMenuRoute';
}

/// generated route for
/// [AdminProductPage]
class AdminProductRoute extends PageRouteInfo<void> {
  const AdminProductRoute()
      : super(AdminProductRoute.name, path: '/admin_product');

  static const String name = 'AdminProductRoute';
}

/// generated route for
/// [AdminSupplierPage]
class AdminSupplierRoute extends PageRouteInfo<void> {
  const AdminSupplierRoute()
      : super(AdminSupplierRoute.name, path: '/admin_supplier');

  static const String name = 'AdminSupplierRoute';
}

/// generated route for
/// [AdminProductUpdatePage]
class AdminProductUpdateRoute
    extends PageRouteInfo<AdminProductUpdateRouteArgs> {
  AdminProductUpdateRoute({Key? key, required ProductModel product})
      : super(AdminProductUpdateRoute.name,
            path: '/admin_product_update',
            args: AdminProductUpdateRouteArgs(key: key, product: product));

  static const String name = 'AdminProductUpdateRoute';
}

class AdminProductUpdateRouteArgs {
  const AdminProductUpdateRouteArgs({this.key, required this.product});

  final Key? key;

  final ProductModel product;

  @override
  String toString() {
    return 'AdminProductUpdateRouteArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [OrderPDFPage]
class OrderPDFRoute extends PageRouteInfo<OrderPDFRouteArgs> {
  OrderPDFRoute({Key? key, required File file})
      : super(OrderPDFRoute.name,
            path: '/order_export_pdf',
            args: OrderPDFRouteArgs(key: key, file: file));

  static const String name = 'OrderPDFRoute';
}

class OrderPDFRouteArgs {
  const OrderPDFRouteArgs({this.key, required this.file});

  final Key? key;

  final File file;

  @override
  String toString() {
    return 'OrderPDFRouteArgs{key: $key, file: $file}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: 'home');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [OrderPage]
class OrderRoute extends PageRouteInfo<void> {
  const OrderRoute() : super(OrderRoute.name, path: 'order');

  static const String name = 'OrderRoute';
}

/// generated route for
/// [AdminSettingPage]
class AdminSettingRoute extends PageRouteInfo<void> {
  const AdminSettingRoute() : super(AdminSettingRoute.name, path: 'admin');

  static const String name = 'AdminSettingRoute';
}
