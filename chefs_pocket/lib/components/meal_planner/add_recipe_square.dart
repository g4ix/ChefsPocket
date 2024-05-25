import 'package:chefs_pocket/components/recipe_card.dart';
import 'package:chefs_pocket/components/saved/recipe_saved_element.dart';
import 'package:chefs_pocket/config.dart';
import 'package:chefs_pocket/models/recipe.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddRecipeSquare extends StatefulWidget {
  Function addRecipeToMeal;
  AddRecipeSquare({required this.addRecipeToMeal});
  @override
  _AddRecipeSquareState createState() => _AddRecipeSquareState();
}

class _AddRecipeSquareState extends State<AddRecipeSquare> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Seleziona una Ricetta'),
              content: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                child: ListView.builder(
                    itemCount: allSavedRecipes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        color: Colors.transparent,
                        height: MediaQuery.of(context).size.height * 0.22,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: RecipeCard(
                          recipe: allSavedRecipes[index],
                          modModify: false,
                          modAdd: true,
                          addRecipe: () {
                            widget.addRecipeToMeal(allSavedRecipes[index]);
                            Navigator.pop(context);
                          },
                        ),
                      );
                    }),
              ),
            );
          },
        );
      },
      child: Container(
        child: DottedBorder(
          padding: EdgeInsets.all(0),
          radius: Radius.circular(10),
          color: Color(0xFF557F9F),
          dashPattern: [5, 5],
          borderType: BorderType.RRect,
          strokeWidth: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF557F9F).withOpacity(0.2),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Color(0xFF557F9F).withOpacity(0.2)),
            ),
            child: Center(
              child: Icon(Icons.add, color: Color(0xFF557F9F), size: 30),
            ),
          ),
        ),
      ),
    );
  }
}
