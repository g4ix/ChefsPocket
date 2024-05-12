import 'package:chefs_pocket/components/meal_planner/clipoval_with_text.dart';
import 'package:flutter/widgets.dart';

class MealRow extends StatelessWidget {
  
  MealRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ClipOvalWithText(
          text: 'Colazione',
          image: 'assets/background/colazione.jpeg',
        ),
        ClipOvalWithText(
          text: 'Pranzo',
          image: 'assets/background/pranzo.jpeg',
        ),
        ClipOvalWithText(
          text: 'Merenda',
          image: 'assets/background/merenda.jpeg',
        ),
        ClipOvalWithText(
          text: 'Cena',
          image: 'assets/background/cena.jpeg',
        ),
      ],
    );
  }
}
