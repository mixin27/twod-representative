import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'errors/error_logger.dart';
import 'features/app/app.dart';

/// Helper class to initialize services and configure the error handlers
class AppBootstrap {
  Widget createRootWidget({required ProviderContainer container}) {
    // * Initialize UserTokenRefreshService
    // container.read(userTokenRefreshServiceProvider);
    // * Initialize RemoteConfigService
    // container.read(remoteConfigServiceProvider);

    // * Register error handlers. For more info, see:
    // * https://docs.flutter.dev/testing/errors
    final errorLogger = container.read(errorLoggerProvider);
    registerErrorHandlers(errorLogger);

    return UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    );
  }
}

void registerErrorHandlers(ErrorLogger errorLogger) {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    errorLogger.logError(details.exception, details.stack);

    if (kReleaseMode) {
      // Pass all uncaught "fatal" errors from the framework to Crashlytics
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    }
  };

  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    errorLogger.logError(error, stack);

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    if (kReleaseMode) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    }
    return true;
  };

  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('An error occurred'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Center(
          child: Text(details.toString()),
        ),
      ),
    );
  };
}
