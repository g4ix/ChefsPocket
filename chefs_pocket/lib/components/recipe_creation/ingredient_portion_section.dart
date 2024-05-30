import 'package:chefs_pocket/components/recipe_creation/set_portions.dart';
import 'package:chefs_pocket/config.dart';
import 'package:chefs_pocket/models/ingredient.dart';
import 'package:chefs_pocket/models/recipe.dart';
import 'package:flutter/material.dart';

import 'ingredient_input.dart';

class IngredientPortionSection extends StatefulWidget {
  List<Ingredient> ingredients;
  Function remove; 
  Map<Ingredient, TextEditingController> ingredientControllers;
  bool useEuUnits;
  Function onPortionChange;
  Recipe recipe;

  IngredientPortionSection(
      {required this.ingredients,
      required this.remove,
      required this.ingredientControllers,
      required this.useEuUnits,
      required this.onPortionChange,
      required this.recipe});

  @override
  _IngredientPortionSectionState createState() =>
      _IngredientPortionSectionState();
}

class _IngredientPortionSectionState extends State<IngredientPortionSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredienti',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Color(0xFF557F9F), 
              ),
        ),
        SizedBox(height: 5),
        Column(
          children: widget.ingredients.map((ingredient) {
            return IngredientInput(
                ingredient: ingredient,
                remove: widget.remove,
                controller: widget.ingredientControllers[ingredient]!,
                units: widget.useEuUnits ? euMeasures : usMeasures);
          }).toList(),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SetPortion(
                    onChangedPortion: widget.onPortionChange,
                    recipe: Recipe(portions: 2),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  Ingredient ingredient =
                      Ingredient(name: '', quantity: 0, unit: '');
                  widget.ingredients.add(ingredient);
                  widget.ingredientControllers[ingredient] =
                      TextEditingController(
                          text: ingredient.quantity.toString());
                  widget.ingredientControllers[ingredient]!.addListener(() {
                    setState(() {
                      ingredient.quantity = double.parse(
                          widget.ingredientControllers[ingredient]!.text);
                    });
                  });
                });
              },
              child: Text(
                '+ Ingrediente',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF557F9F),
                disabledForegroundColor: Color(0xFFF557F9F),
                disabledBackgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
