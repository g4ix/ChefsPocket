import 'package:chefs_pocket/config.dart';
import 'package:chefs_pocket/models/ingredient.dart';
import 'package:flutter/material.dart';

import 'ingredient_input.dart';

class IngredientPortionSection extends StatefulWidget {
  List<Ingredient> ingredients;
  Map<Ingredient, TextEditingController> ingredientControllers;
  bool useEuUnits;
  Function onPortionChange;

  IngredientPortionSection(
      {required this.ingredients,
      required this.ingredientControllers,
      required this.useEuUnits,
      required this.onPortionChange});

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
                color: Color(0xFF557F9F), // Specify the desired color
              ),
        ),
        SizedBox(height: 5),
        Column(
          children: widget.ingredients.map((ingredient) {
            return IngredientInput(
                ingredient: ingredient,
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
                  Row(
                    children: [
                      Text(
                        'Porzioni',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Color(
                                  0xFF557F9F), // Specify the desired color
                            ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 50,
                        height: 35,
                        child: TextFormField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          keyboardType: TextInputType.number,
                          initialValue: '2', // Set the default value to 2
                          decoration: InputDecoration(
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF557F9F), width: 1.0),
                              borderRadius: BorderRadius.circular(
                                  10.0), // make this the same or smaller than the borderRadius for enabledBorder and focusedBorder
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF557F9F), width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF557F9F), width: 2.0),
                                borderRadius: BorderRadius.circular(10.0)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal:
                                    10), // Adjust the vertical and horizontal padding
                            alignLabelWithHint:
                                true, // Align the label with the input field
                          ),
                          onChanged: (value) {
                            widget.onPortionChange(value);
                          },
                        ),
                      ),
                    ],
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
