import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dartfri/features/pageImports.dart';
import 'package:dartfri/providers/appointment_provider.dart';
import 'package:dartfri/providers/places_provider.dart';
import 'package:dartfri/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeDateFormatting(); //very important

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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('en');
    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      initializeDateFormatting();
    }
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Capstone project',

      theme: ThemeData(
        fontFamily: 'Inter',
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
