import 'package:chefs_pocket/components/recipe_creation/ingredient_input.dart';
import 'package:chefs_pocket/components/recipe_creation/set_portions.dart';
import 'package:chefs_pocket/config.dart';
import 'package:chefs_pocket/models/ingredient.dart';
import 'package:chefs_pocket/models/recipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IngredientSection extends StatefulWidget {
  @override
  _IngredientSectionState createState() => _IngredientSectionState();
}

class _IngredientSectionState extends State<IngredientSection> {
  Recipe recipe = mockRecipes[2];
  Map<Ingredient, TextEditingController> ingredientControllers = {};
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //la porzione inserita non deve essere memorizzata nella ricetta, ma è temporanea
                SetPortion(
                    onChangedPortion: (value) {
                      setState(() {
                        recipe.portions = int.parse(value);
                      });
                      // Update recipe portions
                    },
                    recipe: recipe),
                Row(
                  //controllare la logica del toggle
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('US', style: Theme.of(context).textTheme.bodyMedium),
                    Switch(
                      value: recipe.showsEuMeasures,
                      onChanged: (value) {
                        setState(() {
                          recipe.showsEuMeasures = value;
                          if (recipe.showsEuMeasures) {
                            for (int i = 0;
                                i < recipe.ingredients.length;
                                i++) {
                              recipe.ingredients[i].convertToEuunits();

                              ingredientControllers[recipe.ingredients[i]]!
                                      .text =
                                  recipe.ingredients[i].quantity.toString();
                            }
                          } else {
                            for (int i = 0;
                                i < recipe.ingredients.length;
                                i++) {
                              recipe.ingredients[i].convertToUsunits();
                              ingredientControllers[recipe.ingredients[i]]!
                                      .text =
                                  recipe.ingredients[i].quantity.toString();
                            }
                          }
                        });
                      },
                      activeTrackColor: Color(0xFF557F9F),
                      activeColor: Colors.white,
                      inactiveTrackColor: Color(0xFF557F9F),
                      inactiveThumbColor: Colors.white,
                      thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                        (states) {
                          return null; // Torna al tuo codice qui
                        },
                      ),
                    ),
                    Text('EU', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
            Text('Ingredienti', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.primary)),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: recipe.ingredients.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(
                          width: 20,
                        ), // Use a circle icon for the dot
                        Text(
                          recipe.ingredients[index].quantity.toString() +
                              " " +
                              recipe.ingredients[index].unit.toString() +
                              " " +
                              recipe.ingredients[index].name,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ), // Display the array element
                      ],
                    ),
                  );
                },
              ),
            ),
            Text('Tags:' , style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.primary)),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return FilterChip(
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.primary, width: 1),
                    label: Text(recipe.tags[index].name),
                    onSelected: (bool selected) {  },
                    disabledColor: null,
                    labelStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  );
                },
                itemCount: recipe.tags.length,
              ),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
               
                });
              },
              child: Text(
                'Aggiungi alla spesa',
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
            )
          ],
        ),

        //lista di ingredienti della ricetta
      ),
    );
  }
}
