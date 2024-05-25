import 'package:chefs_pocket/components/recipe_creation/ingredient_input.dart';
import 'package:chefs_pocket/components/recipe_creation/set_portions.dart';
import 'package:chefs_pocket/config.dart';
import 'package:chefs_pocket/models/ingredient.dart';
import 'package:chefs_pocket/models/recipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IngredientSection extends StatefulWidget {
  final Recipe recipe;

  const IngredientSection({required this.recipe});

  @override
  _IngredientSectionState createState() => _IngredientSectionState();
}

class _IngredientSectionState extends State<IngredientSection> {
  Map<Ingredient, TextEditingController> ingredientControllers = {};

  @override
  void initState() {
    super.initState();
    widget.recipe.ingredients.forEach((ingredient) {
      ingredientControllers[ingredient] =
          TextEditingController(text: ingredient.quantity.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
       Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //la porzione inserita non deve essere memorizzata nella ricetta, ma è temporanea
                  SetPortion(
                      onChangedPortion: (value) {
                        setState(() {
                          widget.recipe.showsEuMeasures = value;
                          if (widget.recipe.showsEuMeasures) {
                            for (int i = 0;
                                i < widget.recipe.ingredients.length;
                                i++) {
                              widget.recipe.ingredients[i]
                                  .convertPortions(value, widget.recipe.portions);
                              ingredientControllers[widget.recipe.ingredients[i]]!
                                      .text =
                                  widget.recipe.ingredients[i].quantity
                                      .toString();
                            }
                          } else {
                            for (int i = 0;
                                i < widget.recipe.ingredients.length;
                                i++) {
                              widget.recipe.ingredients[i]
                                  .convertPortions(value, widget.recipe.portions);
                              ingredientControllers[widget.recipe.ingredients[i]]!
                                      .text =
                                  widget.recipe.ingredients[i].quantity
                                      .toString();
                            }
                          }
                        });
                        // Update recipe portions
                      },
                      recipe: widget.recipe),
                  Row(
                    //controllare la logica del toggle
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('US', style: Theme.of(context).textTheme.bodyMedium),
                      Switch(
                        value: widget.recipe.showsEuMeasures,
                        onChanged: (value) {
                          setState(() {
                            widget.recipe.showsEuMeasures = value;
                            if (widget.recipe.showsEuMeasures) {
                              for (int i = 0;
                                  i < widget.recipe.ingredients.length;
                                  i++) {
                                widget.recipe.ingredients[i].convertToEuunits();
                                ingredientControllers[
                                            widget.recipe.ingredients[i]]!
                                        .text =
                                    widget.recipe.ingredients[i].quantity
                                        .toString();
                              }
                            } else {
                              for (int i = 0;
                                  i < widget.recipe.ingredients.length;
                                  i++) {
                                widget.recipe.ingredients[i].convertToUsunits();
                                ingredientControllers[
                                            widget.recipe.ingredients[i]]!
                                        .text =
                                    widget.recipe.ingredients[i].quantity
                                        .toString();
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
              Text('Cosa ti serve:',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.primary)),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount: widget.recipe.ingredients.length,
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
                            '${widget.recipe.ingredients[index].quantity} ${widget.recipe.ingredients[index].unit} ${widget.recipe.ingredients[index].name}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ), // Display the array element
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Tags:',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Theme.of(context).colorScheme.primary)),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Wrap(
                  children: widget.recipe.tags.map((tag) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilterChip(
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1),
                        label: Text(tag.name, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.primary)),
                        onSelected: (bool selected) {},
                        disabledColor: null,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.primary),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    );
                  }).toList(),
                ),
              ),
             
            ],
            
          ),
    
          //lista di ingredienti della ricetta
         Positioned(
                bottom: MediaQuery.of(context).size.height * .1, // Distance from the bottom of the screen
                left:MediaQuery.of(context).size.width * .2,
                right: MediaQuery.of(context).size.width * .2,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {});
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
                ),
              ),
      ]),
    );
  }
}
