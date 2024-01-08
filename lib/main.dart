import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vista/constants/app_colors.dart';
import 'package:vista/pages/home_page.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        // title: 'Flutter Demo',
        theme: CupertinoThemeData(
            primaryColor: AppColors.greenButtonColor,
            brightness: Brightness.dark
            // primaryContrastingColor: Colors.green,
            //textTheme: CupertinoTextThemeData(),
            //  barBackgroundColor: Colors.pink,
            // scaffoldBackgroundColor: Colors.yellow,
            // applyThemeToAll: true,
            ),
        // theme: CupertinoThemeData(brightness: Brightness.dark),
        home: HomePage());
  }
}
