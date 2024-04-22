import 'package:chefs_pocket/models/step.dart';

class Recipe {
  final String title;
  final String description;
  final String imageUrl;
  final String ingredients;
  final List<Step> steps;
  final int numPersone;

  Recipe({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.numPersone,
  });
}

