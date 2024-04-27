import 'dart:html';

import 'package:flutter/widgets.dart';

import '../models/ingredient.dart';

class IngredientInputCard extends StatefulWidget {
  Ingredient ingredient = Ingredient();

  const IngredientInputCard({required this.ingredient});

  @override
  State<IngredientInputCard> createState() {
    return _IngredientInputCardState();
  }
}

class _IngredientInputCardState extends State<IngredientInputCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          TextField(
            onChanged: (value) {
              // Update the recipe's ingredient
              widget.ingredient.name = value;
            },
            decoration: InputDecoration(
              labelText: 'Ingredient',
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            onChanged: (value) {
              // Update the recipe's ingredient
              widget.ingredient.quantity = value;
            },
            decoration: InputDecoration(
              labelText: 'Ingredient',
              border: OutlineInputBorder(),
            ),
          ),
          ButtonElement(
            onPressed: () {
              // Update the recipe's ingredient
              provider.recipe.ingredients.add(widget.ingredient);
            },
            child: Text(widget.ingredient.EU ? 'EU' : 'US'),
          )
        ],
      ),
    );
  }
}
