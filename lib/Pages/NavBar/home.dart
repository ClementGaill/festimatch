// ignore_for_file: avoid_unnecessary_containers
import 'package:festimatch/Widgets/Frontend/Cards/styleCards.dart';
import 'package:festimatch/Widgets/Frontend/colors.dart';
import 'package:festimatch/Widgets/Frontend/Cards/swipeCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CardSwiperController controller = CardSwiperController();
  List<Container> cards = [
    Container(
      child: CustomCard(
        title: 'Title 1',
        subtitle: 'Subtitle 1',
        imageUrl: 'https://cloudfront-eu-central-1.images.arcpublishing.com/liberation/55QGXVJ3FDNS2H2FVOPJCCK7KA.jpg',
      ),
    ),
    Container(
      child: CustomCard(
        title: 'Title 2',
        subtitle: 'Subtitle 2',
        imageUrl: 'https://cloudfront-eu-central-1.images.arcpublishing.com/liberation/55QGXVJ3FDNS2H2FVOPJCCK7KA.jpg',
      ),
    ),
    Container(
      child: CustomCard(
        title: 'Title 3',
        subtitle: 'Subtitle 3',
        imageUrl: 'https://cloudfront-eu-central-1.images.arcpublishing.com/liberation/55QGXVJ3FDNS2H2FVOPJCCK7KA.jpg',
      ),
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
          
            children: [
              Container(
                constraints: BoxConstraints(maxHeight: 450),
                child: CardSwipe(controller: controller, cards: cards),
              ),
          
              const SizedBox(height: 25.0,),
          
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      color: errorColor,
                      onPressed: () {
                        controller.swipe(CardSwiperDirection.left);
                      }, icon: Icon(LucideIcons.circleHelp, size: 37,)
                    ),
          
                    Container(
                      decoration: BoxDecoration(
                        color: errorColor,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: IconButton(
                        color: backgroundColor,
                        onPressed: () {
                          controller.swipe(CardSwiperDirection.left);
                        }, icon: Icon(LucideIcons.x, size: 45,)
                      ),
                    ),
          
                    Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: IconButton(
                        color: backgroundColor,
                        onPressed: () {
                          controller.swipe(CardSwiperDirection.right);
                        }, icon: Icon(LucideIcons.check, size: 45,)
                      ),
                    ),
          
                    IconButton(
                      color: primaryColor,
                      onPressed: () {
                        controller.swipe(CardSwiperDirection.top);
                      }, icon: Icon(Icons.favorite, size: 37,)
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//https://chat.mistral.ai/chat/4cff1292-668e-4e4f-b2a7-1c9602fb6f1b