import 'package:festimatch/Pages/Auth/selectRooms.dart';
import 'package:festimatch/Pages/Auth/welcome.dart';
import 'package:festimatch/Widgets/Frontend/colors.dart';
import 'package:festimatch/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            backgroundColor: primaryColor,
            elevation: 0,
            foregroundColor: backgroundColor,
            minimumSize: widgets.Size(
              double.infinity,
              50,
            ), // Bouton pleine largeur, hauteur personnalisée
            textStyle: GoogleFonts.spaceGrotesk(
              fontWeight: FontWeight.bold,
              color: textColor,
              fontSize: 20,
            ),
          ),
        ),

        appBarTheme: AppBarTheme(
          centerTitle: false,
          titleTextStyle: GoogleFonts.bricolageGrotesque(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: SplashedScreen(),
    );
  }
}

class SplashedScreen extends StatefulWidget {
  const SplashedScreen({super.key});

  @override
  State<SplashedScreen> createState() => _SplashedScreenState();
}

class _SplashedScreenState extends State<SplashedScreen> {
  bool isLoggedIn = false;
  
  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isConnected = prefs.getBool('isConnected');

    if (isConnected == true) {
      setState(() {
        isLoggedIn = true;
      });
      navigateToSelectrooms();
    } else {
      navigateToLogin();
    }
  }

  void navigateToSelectrooms() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Selectrooms()),
    );
  }

  void navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WelcomePage()),
    );
  }

  @override
  void initState() {
    checkLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}