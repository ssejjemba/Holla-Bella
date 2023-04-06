import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:holla_bella/src/config/route.dart';
import 'package:holla_bella/src/screens/product_detail.dart';
import 'package:holla_bella/src/screens/welcome.dart';
import 'package:holla_bella/src/themes/theme.dart';
import 'package:holla_bella/src/widgets/custom_route.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Layiisi',
      theme: AppTheme.lightTheme.copyWith(
          textTheme: GoogleFonts.mulishTextTheme(textTheme).copyWith(
              bodyLarge:
                  GoogleFonts.montserrat(textStyle: textTheme.bodyLarge))),
      routes: Routes.getRoute(),
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name!.contains('detail')) {
          return CustomRoute<bool>(
              builder: (BuildContext context) => ProductDetail(),
              settings: settings);
        } else {
          return CustomRoute<bool>(
              builder: (BuildContext context) => Welcome(title: 'Layiisi'),
              settings: settings);
        }
      },
      initialRoute: '/',
    );
  }
}
