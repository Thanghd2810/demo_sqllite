import 'package:auto_route/auto_route.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/utils/utils.dart';
import 'route/router.dart';
import 'theme/theme.dart';

class App extends HookConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.read(routerProvider);

    return DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => AppResponsive(
        child: MaterialApp.router(
          title: 'Sky Food',
          // Theme
          theme: kLightThemeData,
          darkTheme: kLightThemeData,
          debugShowCheckedModeBanner: false,
          // Router
          routeInformationParser: appRouter.defaultRouteParser(),
          routerDelegate: AutoRouterDelegate(
            appRouter,
            navigatorObservers: () => [ref.read(routerObserverProvider)],
          ),
        ),
      ),
    );
  }
}
