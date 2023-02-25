import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dartfri/features/pageImports.dart';
import 'package:dartfri/providers/appointment_provider.dart';
import 'package:dartfri/providers/places_provider.dart';
import 'package:dartfri/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => AppointmentProvider()),
          ChangeNotifierProvider(create: (context) => PlacesProvider()),
          // ChangeNotifierProvider(create: (context) => MessageProvider()),


        ],
        child: MyApp(),
      ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Capstone project',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary:  Palette.primaryDartfri,
            // secondary: const Color(0xFF16E4E4)
            // secondary: const Color(0xFFFFC107),
            // primaryColor: Colors.cyanAccent,

          )),
        builder: BotToastInit(), //1. call BotToastInit
        navigatorObservers: [BotToastNavigatorObserver()],
      home: AnimatedSplashScreen(
          duration: 2000,
          splash: Container(

            child: Image.asset('assets/logo_noback.png'),),
          nextScreen: (FirebaseAuth.instance?.currentUser != null) ?
          LoginPage(): WelcomeSlider(),
          splashTransition: SplashTransition.fadeTransition,
          splashIconSize: 250,
          backgroundColor: Colors.white),
    );
  }
}
