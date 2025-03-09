import 'package:festimatch/Pages/NavBar/navbar.dart';
import 'package:festimatch/Widgets/Frontend/colors.dart';
import 'package:festimatch/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Festimatch',
      theme: ThemeData(
        textTheme: GoogleFonts.bricolageGrotesqueTextTheme(),
        colorScheme: colorScheme,

        appBarTheme: AppBarTheme(
          centerTitle: false,
          titleTextStyle: GoogleFonts.bricolageGrotesque(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: NavBar(),
    );
  }
}