// ignore_for_file: library_private_types_in_public_api

import 'package:festimatch/Pages/Auth/selectRooms.dart';
import 'package:festimatch/Widgets/Frontend/colors.dart';
import 'package:festimatch/Widgets/Frontend/textField.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/festival.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
              color: backgroundColor
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Bienvenue',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Trouve le planning parfait pour ton festival',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => LoginBottomSheet(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Se connecter'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({super.key});

  @override
  _LoginBottomSheetState createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isChecked = false;
  String? errorCheckBox;

  Future<void> handleLogin() async {
    if (!isChecked) {
      setState(() {
        errorCheckBox = 'Merci d\'accepter les Conditions générales d\'utilisation';
      });
      return;
    }

    try {
      // Tentative de connexion
      // ignore: unused_local_variable
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Si la connexion réussit, rediriger vers Selectrooms
      navigateToSelectrooms();
    } on FirebaseAuthException catch (e) {
      try {
        await createNewUser();
      } catch (signupError) {
        Fluttertoast.showToast(
          msg: 'Erreur lors de l\'inscription : $signupError',
        );
      }
      print(e);
    } catch (e) {
      // Gérer les autres erreurs inattendues
      Fluttertoast.showToast(
        msg: 'Erreur inattendue : $e',
      );
    }
  }

  Future<void> createNewUser() async {
    final UserCredential newUser = await _auth.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    final String userId = newUser.user?.uid ?? '';

    await FirebaseFirestore.instance.collection('Users').doc(userId).set({
      'createdAt': FieldValue.serverTimestamp(),
      'userName': 'test',
      'imageUrl': 'https://google.com/'
    });

    // Rediriger vers Selectrooms après la création du compte
    navigateToSelectrooms();
  }


  void navigateToSelectrooms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isConnected', true);
    
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: Selectrooms(),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomizedTextField(
              controller: emailController,
              textInputAction: TextInputAction.done,
              length: 50,
              minLines: 1,
              maxLines: 1,
              icon: Icon(LucideIcons.letterText),
              label: 'Email',
              textInputType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
            ),
            SizedBox(height: 10),
            CustomizedTextField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              length: 50,
              minLines: 1,
              maxLines: 1,
              icon: Icon(LucideIcons.lock),
              label: 'Mot de passe',
              textInputType: TextInputType.text,
              obscureText: true,
              textCapitalization: TextCapitalization.none,
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              child: Text('Mot de passe oublié ?'),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    'En continuant, tu acceptes les Conditions d\'utilisation',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
            if (errorCheckBox != null)
              Text(
                errorCheckBox!,
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: handleLogin,
              child: Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}
