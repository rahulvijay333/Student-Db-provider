import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase/firebase_provider.dart';
import 'package:flutter_application_1/presentation/splash/screen_splash.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

const uniquekey = Uuid();

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
         
          ChangeNotifierProvider(
            create: (context) => FirebaseProvider(),
          )
        ],
        child: GetMaterialApp(
          theme: ThemeData(
              appBarTheme:
                  const AppBarTheme(backgroundColor: Colors.deepPurple),
              elevatedButtonTheme: const ElevatedButtonThemeData(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.deepPurple))),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepPurple)),
          home: const ScreenSplash(),
        ));
  }
}
