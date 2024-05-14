import 'package:chefs_pocket/components/meal_planner/clipoval_with_text.dart';
import 'package:flutter/widgets.dart';

class MealRow extends StatefulWidget {
  MealRow();

  @override
  State<MealRow> createState() => _MealRowState();
}

class _MealRowState extends State<MealRow> {
  String? lastPressed;
  List<bool> isSelected = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ClipOvalWithText(
          text: 'Colazione',
          image: 'assets/background/colazione.jpeg',
          isSelected: isSelected[0],
          onPressed: () {
            setState(() {
              changeSelected(isSelected, 0);
              lastPressed = 'Colazione';
              print(lastPressed);
            });
          },
        ),
        ClipOvalWithText(
          text: 'Pranzo',
          image: 'assets/background/pranzo.jpeg',
          isSelected: isSelected[1],
          onPressed: () {
            setState(() {
             changeSelected(isSelected, 1);
              lastPressed = 'Pranzo';
              print(lastPressed);
            });
          },
        ),
        ClipOvalWithText(
          text: 'Merenda',
          image: 'assets/background/merenda.jpeg',
          isSelected: isSelected[2],
          onPressed: () {
            setState(() {
              changeSelected(isSelected, 2);
              lastPressed = 'Merenda';
              print(lastPressed);
            });
          },
        ),
        ClipOvalWithText(
          text: 'Cena',
          image: 'assets/background/cena.jpeg',
          isSelected: isSelected[3],
          onPressed: () {
            setState(() {
              changeSelected(isSelected, 3);
              lastPressed = 'Cena';
              print(lastPressed);
            });
          },
        ),
      ],
    );
  }
}

void changeSelected(List<bool> isSelected, int index) {
  for (int i = 0; i < isSelected.length; i++) {
    if (i != index) {
      isSelected[i] = false;
    } else {
      isSelected[i] = true;
    }
  }
}
