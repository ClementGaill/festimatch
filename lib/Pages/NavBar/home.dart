import 'package:festimatch/Widgets/Frontend/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          SizedBox(
            width: 200,
            height: 300,
            child: Stack(
              children: [
                //Card
                Container(
                  color: primaryColor,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}