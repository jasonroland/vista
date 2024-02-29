import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vista/constants/app_colors.dart';
import 'package:vista/firebase_options.dart';
import 'package:vista/pages/home_page.dart';
import 'package:vista/pages/welcome_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //this const might mess things up?
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return CupertinoApp(
        // title: 'Flutter Demo',
        theme: const CupertinoThemeData(
            primaryColor: AppColors.yellowButtonColor, //greeenbuttoncolor
            brightness: Brightness.dark
            // primaryContrastingColor: Colors.green,
            //textTheme: CupertinoTextThemeData(),
            //  barBackgroundColor: Colors.pink,
            // scaffoldBackgroundColor: Colors.yellow,
            // applyThemeToAll: true,
            ),
        // theme: CupertinoThemeData(brightness: Brightness.dark),
//this shows the home page to signed in user and welcome page to non signed in user
//TODO: if user signs in for the first time but doesnt create his account and closes app
//and signs back in app will take him to home page, need code to check if account is
//set up and if not take him to create profile page.
        home:
            auth.currentUser != null ? const HomePage() : const WelcomePage());
  }
}
