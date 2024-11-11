import 'package:learn_riverpod/src/core/riverpod/startup/app_startup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'startup_error_widget.dart';

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({
    super.key,
    required this.loading,
    required this.loaded,
  });

  final Widget loading;
  final Widget loaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appStartupProvider);

    return appStartupState.when(
      data: (_) => loaded,
      error: (error, stackTrace) {
        return AppStartupErrorWidget(
          errorMessage: error.toString(),
          onRetry: () => ref.invalidate(appStartupProvider),
        );
      },
      loading: () => loading,
    );
  }
}
