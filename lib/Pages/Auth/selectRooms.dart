// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festimatch/Pages/NavBar/navbar.dart';
import 'package:festimatch/Widgets/BackEnd/generateCode.dart';
import 'package:festimatch/Widgets/Frontend/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:page_transition/page_transition.dart';

class Selectrooms extends StatefulWidget {
  const Selectrooms({super.key});

  @override
  State<Selectrooms> createState() => _SelectroomsState();
}

class _SelectroomsState extends State<Selectrooms> {
  String festivalSelected = 'Le festival :';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
                
          children: [
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: primaryColor,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.person_2_rounded, color: backgroundColor, size: 100,),
                    Icon(LucideIcons.camera, color: primaryColor, size: 30,),
                  ],
                ),
              ),
            ),
        
            const SizedBox(height: 10,),
        
            Align(
              alignment: Alignment.center,
              child: Text('Hello, Clément !', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),),
            ),

            const SizedBox(height: 15.0,),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: greyColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonHideUnderline(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10), // Facultatif : coins arrondis
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        child: DropdownButton<String>(
                          isExpanded: true, // Permet d'occuper tout l'espace disponible
                          hint: Text(festivalSelected),
                          items: <String>['Les Vieilles Charrues', 'Solidays', 'We Love Green Festival',].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged:(value) {
                            setState(() {
                              festivalSelected = value.toString();
                            });
                            print(value);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 5.0,),

                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        backgroundColor: backgroundColor,
                        elevation: 0,
                        foregroundColor: primaryColor,
                        minimumSize: widgets.Size(double.infinity, 50), // Bouton pleine largeur, hauteur personnalisée
                        textStyle: GoogleFonts.spaceGrotesk(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          fontSize: 20
                        ),
                      ), 
                      child: Text('Je festival solo !'),
                    ),
                    const SizedBox(height: 5.0,),
                    ElevatedButton(
                        onPressed: () {
                          final code = generateCodeFromTimestamp();

                          print(code);

                          try {

                            //TODO: Changer creator par un dynamique
                            FirebaseFirestore.instance.collection('Rooms').doc(code).set({
                              'code': code,
                              'creator': 'JohnDoe',
                              'createdAt': DateTime.timestamp(),
                              'festival': festivalSelected,
                            }).then((value) {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: NavBar(),
                                ),
                              );
                            },);
                          } catch (e) {
                            print(e);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Erreur : $e'),
                                backgroundColor: errorColor, // Rouge pour signaler une erreur
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                          backgroundColor: backgroundColor,
                          elevation: 0,
                          foregroundColor: secondaryColor,
                          minimumSize: widgets.Size(double.infinity, 50), // Bouton pleine largeur, hauteur personnalisée
                          textStyle: GoogleFonts.spaceGrotesk(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          fontSize: 20
                        ),
                      ), 
                      child: Text('Crée une room'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15.0,),

            ElevatedButton(
              onPressed: () {
                showJoinRoomDialog(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
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
              child: Text('Rejoindre une room'),
            ),
          ],
        ),
      ),
    );
  }
}

void showJoinRoomDialog(BuildContext context) {
  TextEditingController _controller = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Theme.of(context).platform == TargetPlatform.iOS
          ? CupertinoAlertDialog(
              title: Text("Rejoindre une room"),
              content: Column(
                children: [
                  SizedBox(height: 10),
                  CupertinoTextField(
                    controller: _controller,
                    maxLength: 6,
                    placeholder: "Code (6 caractères)",
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
              actions: [
                CupertinoDialogAction(
                  child: Text("Annuler"),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoDialogAction(
                  child: Text("Rejoindre"),
                  onPressed: () {
                    String code = _controller.text.trim();
                    if (code.length == 6) {
                      // Ajoute ici la logique pour rejoindre la room
                      print("Rejoindre la room : $code");
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            )
          : AlertDialog(
              title: Text("Rejoindre une room"),
              content: TextField(
                controller: _controller,
                maxLength: 6,
                decoration: InputDecoration(
                  hintText: "Code (6 caractères)",
                  counterText: "",
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
              ),
              actions: [
                TextButton(
                  child: Text("Annuler", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: errorColor,),),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: Text("Rejoindre"),
                  onPressed: () {
                    String code = _controller.text.trim();
                    if (code.length == 6) {
                      // Ajoute ici la logique pour rejoindre la room
                      print("Rejoindre la room : $code");
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            );
    },
  );
}
