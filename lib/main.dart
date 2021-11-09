import 'package:app_ninja_task/screens/first_screen.dart';
import 'package:app_ninja_task/screens/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
 Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STORAGE',
      theme: ThemeData(
        popupMenuTheme: PopupMenuThemeData(color: Colors.grey[100],),
        shadowColor: Colors.blue,
        // textTheme:
        //     GoogleFonts.pacificoTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstScreen(),
        '/SecondScreen': (context) => const SecondScreen(),
      //   '/ForgotPassword': (context) => ForgotPassword(),
      //   '/CreateNewAccount': (context) => CreateNewAccount(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}