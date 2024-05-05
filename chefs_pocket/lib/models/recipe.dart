import 'package:chefs_pocket/config.dart';
import 'package:chefs_pocket/models/ingredient.dart';
import 'package:uuid/uuid.dart';
import 'package:chefs_pocket/models/section.dart';
import 'package:chefs_pocket/models/recipe_step.dart';

class Recipe {
  String id = const Uuid().v4(); //id per riconoscere la ricetta
  String title = "";
  String imageUrl = "";
  int rating = 0; //da 1 a 5
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
    this.showsEuMeasures = true,
    this.steps = const [],
    this.totalTime = const Duration(hours: 0, minutes: 0, seconds: 0),
    this.tags = const [],
    this.ingredients = const [],
  });

  void setTitle(String title) {
    this.title = title;
  }

  void setRating(int rating) {
    this.rating = rating;
  }

  void setPortions(int portions) {
    this.portions = portions;
  }

  void setTotalTime(Duration totalTime) {
    this.totalTime = totalTime;
  }

  void addIngredient(Ingredient ingredient) {
    ingredients.add(ingredient);
  }

  void removeIngredient(Ingredient ingredient) {
    ingredients.remove(ingredient);
  }

  void addStep(RecipeStep step) {
    steps.add(step);
  }

  void removeStep(RecipeStep step) {
    steps.remove(step);
  }

  void addTag(Tag tag) {
    tags.add(tag);
  }

  void removeTag(Tag tag) {
    tags.remove(tag);
  }

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
