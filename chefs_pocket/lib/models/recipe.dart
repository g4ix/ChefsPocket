import 'package:chefs_pocket/config.dart';
import 'package:chefs_pocket/models/ingredient.dart';
import 'package:uuid/uuid.dart';
import 'package:chefs_pocket/models/section.dart';
import 'package:chefs_pocket/models/recipe_step.dart';

class Recipe {
  String id = const Uuid().v4(); //id per riconoscere la ricetta
  String title = "";
  String imageUrl = "";
  int rating = 0;  //da 1 a 5
  int portions = 0;
  List<Ingredient> ingredients = [];
  bool showsEuMeasures = true;
  List<RecipeStep> steps = [];
  Duration totalTime = const Duration(hours: 0, minutes: 0, seconds: 0);
  List<Tag> tags = []; //enum

  Recipe({
    this.title = "",
    this.imageUrl = "",
    this.rating = 0,  
    this.portions = 0,  
    this.ingredients = const [],
    this.showsEuMeasures = true,
    this.steps = const [],
    this.totalTime = const Duration(hours: 0, minutes: 0, seconds: 0),
    this.tags = const [], 
  });

  void convertToEuMeasures() {
    if (!showsEuMeasures) {
      for (var i = 0; i < ingredients.length; i++) {
        ingredients[i].convertToEuunits();
      }
      showsEuMeasures = true;
    }
  }

  void convertToUsMeasures() {
    if (showsEuMeasures) {
      for (var i = 0; i < ingredients.length; i++) {
        ingredients[i].convertToUsunits();
      }
      showsEuMeasures = false;
    }
  }
}

