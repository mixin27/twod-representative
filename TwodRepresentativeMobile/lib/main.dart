import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:twod_representative/src/app_bootstrap_firebase.dart';
import 'package:twod_representative/src/shared/utils/socketio.dart';
import 'firebase_options.dart';
import 'src/app_bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SocketService().initConnection();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final appBootstrap = AppBootstrap();
  await appBootstrap.setupAnalytics();

  final container = await appBootstrap.createFirebaseProviderContainer();
  final root = appBootstrap.createRootWidget(container: container);

  runApp(root);
}
