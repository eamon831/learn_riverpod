import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/core/service/router/router.dart';
import 'src/core/theme/theme.dart';
import 'src/core/logger/riverpod_log.dart';

void main() {
  runApp(
    ProviderScope(
      observers: [
        RiverPodObserver(),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MediaQuery.withClampedTextScaling(
      maxScaleFactor: 1.5,
      child: MaterialApp.router(
        theme: context.themeData,
        routerConfig: ref.read(goRouterProvider),
      ),
    );
  }
}
