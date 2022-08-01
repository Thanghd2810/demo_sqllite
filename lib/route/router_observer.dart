part of router;

/// Get [context] with Provider
final contextProvider = Provider<BuildContext>(
  (_) => AppRouterObserver().context,
);

/// router Observer
final routerObserverProvider = Provider<AppRouterObserver>(
  (_) => AppRouterObserver(),
);

class AppRouterObserver extends AutoRouterObserver {
  AppRouterObserver._();

  static AppRouterObserver? _instance;

  factory AppRouterObserver() => _instance ??= AppRouterObserver._();

  late BuildContext context;

  @override
  void didPush(Route route, Route? previousRoute) {
    context = route.navigator!.context;

    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    context = route.navigator!.context;

    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    context = route.navigator!.context;

    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    context = newRoute!.navigator!.context;

    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
