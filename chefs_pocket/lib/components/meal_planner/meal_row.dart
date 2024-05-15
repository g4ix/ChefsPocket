import 'package:chefs_pocket/components/meal_planner/clipoval_with_text.dart';
import 'package:flutter/widgets.dart';

class MealRow extends StatefulWidget {
  Function onMealSelection;
  MealRow(this.onMealSelection);

  @override
  State<MealRow> createState() => _MealRowState();
}

class _MealRowState extends State<MealRow> {
  String? lastPressed = 'Colazione';
  List<bool> isSelected = [true, false, false, false];

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
              widget.onMealSelection(lastPressed!);
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
              widget.onMealSelection(lastPressed!);
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
              widget.onMealSelection(lastPressed!);
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
              widget.onMealSelection(lastPressed!);
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
