import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_riverpod/src/core/di/dependency_injection.dart';
import 'package:learn_riverpod/src/core/extensions/riverpod_extensions.dart';
import 'package:learn_riverpod/src/core/logger/log.dart';
import 'package:learn_riverpod/src/core/service/cache/cache_service.dart';
import 'package:learn_riverpod/src/core/widgets/app_startup/startup_widget.dart';
import 'package:learn_riverpod/src/features/onboarding/presentation/view/onboarding_page.dart';
import 'package:learn_riverpod/src/features/splash/presentation/view/splash_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'router_state/router_state_provider.dart';
import 'routes.dart';

// Add the part directive with the correct filename
part 'router.g.dart';
part 'parts/on_boarding_routes.dart';

// Define the root navigator key
final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Root');

// Define the provider using @Riverpod
@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    refreshListenable: ref.asListenable(routerStateProvider),
    initialLocation: Routes.initial,
    redirect: (context, state) {
      Log.info('Redirecting to ${state.uri}');
      if ([
        Routes.initial,
        //Routes.onboarding,
        Routes.splash,
      ].contains(state.uri.path)) {
        return ref.asListenable(routerStateProvider).value;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: Routes.initial,
        name: Routes.initial,
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: AppStartupWidget(
              loading: SplashPage(),
              loaded: SplashPage(),
            ),
          );
        },
      ),
      ..._onboardingRoutes(ref),
    ],
  );
}
