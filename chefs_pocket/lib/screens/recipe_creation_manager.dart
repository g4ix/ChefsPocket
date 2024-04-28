import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../models/ingredient.dart';
import '../models/section.dart';
import '../models/recipe_step.dart';
import '../config.dart';

class RecipeManager extends ChangeNotifier {
  Recipe _recipe = Recipe();

  Recipe get recipe => _recipe;

  void setTitle(String title) {
    _recipe.title = title;
    notifyListeners();
  }

  void setImageUrl(String imageUrl) {
    _recipe.imageUrl = imageUrl;
    notifyListeners();
  }

  void setRating(int rating) {
    _recipe.rating = rating;
    notifyListeners();
  }

  void setPortions(int portions) {
    _recipe.portions = portions;
    notifyListeners();
  }

  void addIngredient(Section section, Ingredient ingredient) {
    // Find the specified section within the recipe's sections list
    final index = _recipe.sections.indexOf(section);

    // Check if the section exists
    if (index != -1) {
      // Add the ingredient to the ingredients list of the found section
      _recipe.sections[index].ingredients.add(ingredient);
    } else {
      // If the section doesn't exist, create a new section with the ingredient
      _recipe.sections.add(Section(title: "", ingredients: [ingredient]));
    }

    // Notify listeners about the state change
    notifyListeners();
  }

  void removeIngredient(Section section, Ingredient ingredient) {
    // Find the specified section within the recipe's sections list
    final index = _recipe.sections.indexOf(section);

    // Check if the section exists
    if (index != -1) {
      // Remove the ingredient from the ingredients list of the found section
      _recipe.sections[index].ingredients.remove(ingredient);
    }

    // Notify listeners about the state change
    notifyListeners();
  }

  void addSection(Section section) {
    _recipe.sections.add(section);
    notifyListeners();
  }

  void removeSection(Section section) {
    _recipe.sections.remove(section);
    notifyListeners();
  }

  void addStep(RecipeStep step) {
    _recipe.steps.add(step);
    notifyListeners();
  }

  void removeStep(RecipeStep step) {
    _recipe.steps.remove(step);
    notifyListeners();
  }

  void setDuration(Duration duration) {
    _recipe.totalTime = duration;
    notifyListeners();
  }

  void setTags(List<Tag> tags) {
    _recipe.tags = tags;
    notifyListeners();
  }
}
