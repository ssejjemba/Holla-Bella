import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:holla_bella/injection.dart';
import 'package:holla_bella/src/screens/app.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection(Environment.prod);
  initialiseFireBase();
  runApp(const MyApp());
}

void initialiseFireBase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
