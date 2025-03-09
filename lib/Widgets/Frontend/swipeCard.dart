// ignore_for_file: file_names, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';

class SwipeCard extends StatelessWidget {
  final color;
  const SwipeCard({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Swipable(
      onSwipeRight: (finalPosition) {
        print('Swipe Right');
      },
      onSwipeLeft: (finalPosition) {
        print('Swipe Left');
      },
      onSwipeUp: (finalPosition) {
        print('Swipe Up');
      },
      child: Container(
        color: color,
      ),
    );
  }
}