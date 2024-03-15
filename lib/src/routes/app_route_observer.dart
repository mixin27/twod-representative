import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AppRouteObserver extends AutoRouteObserver {
  @override
  void didPush(Route route, Route? previousRoute) async {
    debugPrint('New route pushed: ${route.settings.name}');
    await FirebaseAnalytics.instance.logScreenView(
      screenClass: route.settings.name?.replaceAll('Route', 'Page'),
      screenName: route.settings.name,
    );
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    debugPrint('Route popped: ${route.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    debugPrint(
      'Route replaced: ${oldRoute?.settings.name} -> ${newRoute?.settings.name}',
    );
  }
}
