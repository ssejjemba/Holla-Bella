import 'package:flutter/material.dart';
import 'package:holla_bella/src/screens/home.dart';
import 'package:holla_bella/src/screens/login.dart';
import 'package:holla_bella/src/screens/main.dart';
import 'package:holla_bella/src/screens/register.dart';
import 'package:holla_bella/src/screens/welcome.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => Welcome(
            title: 'Layiisi',
          ),
      '/login': (_) => Login(),
      '/register': (_) => SignUp(),
      '/home': (_) => const Main(title: 'Layiisi')
    };
  }
}
