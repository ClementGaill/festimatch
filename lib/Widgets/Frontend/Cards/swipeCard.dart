// ignore_for_file: file_names

import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter/material.dart';

class CardSwipe extends StatelessWidget {
  final CardSwiperController controller;
  final List<Container> cards;

  const CardSwipe({super.key, required this.controller, required this.cards});

  @override
  Widget build(BuildContext context) {
    return CardSwiper(
      onSwipe: (previousIndex, currentIndex, direction) {
        debugPrint(
          'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
        );

        return true;
      },
      numberOfCardsDisplayed: 2,
      backCardOffset: Offset(-4, 25),
      allowedSwipeDirection: AllowedSwipeDirection.only(up: true, left: true, right: true),
      isLoop: true,
      controller: controller,
      cardsCount: cards.length,
      cardBuilder: (context, index, percentThresholdX, percentThresholdY) => cards[index],
    );
  }
}