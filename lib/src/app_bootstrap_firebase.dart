import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_bootstrap.dart';
import 'errors/async_error_logger.dart';

/// Extension methods specific for the Firebase project configuration
extension AppBootstrapFirebase on AppBootstrap {
  Future<ProviderContainer> createFirebaseProviderContainer({
    List<Override> overrides = const [],
  }) async {
    return ProviderContainer(
      overrides: overrides,
      observers: [
        AsyncErrorLogger(),
      ],
    );
  }

  Future<void> setupAnalytics() async {
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  }

  Future<void> setupEmulators() async {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
    // * When running on the emulator, disable persistence to avoid discrepancies
    // * between the emulated database and local caches. More info here:
    // * https://firebase.google.com/docs/emulator-suite/connect_firestore#instrument_your_app_to_talk_to_the_emulators
    FirebaseFirestore.instance.settings =
        const Settings(persistenceEnabled: false);
  }
}
