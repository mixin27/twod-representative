import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:twod_representative/firebase_options.dart';
import 'src/features/app/presentation/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
