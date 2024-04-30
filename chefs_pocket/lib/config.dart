import 'package:chefs_pocket/models/ingredient.dart';
import 'package:chefs_pocket/models/recipe.dart';
import 'package:chefs_pocket/models/recipe_step.dart';

List<String> euMeasures = [
  "g",
  "ml",
  "l",
  "kg",
];

List<String> usMeasures = [
  "oz",
  "fl oz",
  "gal",
  "lb",
  "tbsp",
  "tsp",
  "cup",
];

enum Tag {
  Dolce,
  Primo,
  Secondo,
  Vegano,
  Bevanda,
  NoGlutine,
  Contorno,
  Vegetariano,
  Carne,
  Pesce,
}

List<Recipe> mockRecipies = [
  Recipe(
    title: "Pasta al Pomodoro",
    tags: [Tag.Primo],
    ingredients: [
      Ingredient(
        name: "Pasta",
        quantity: 100,
        unit: "g",
      ),
      Ingredient(
        name: "Pomodoro",
        quantity: 200,
        unit: "g",
      ),
      Ingredient(
        name: "Basilico",
        quantity: 5,
        unit: "g",
      ),
    ],
    steps: [
      RecipeStep(
        title: "Preparazione",
        description: "Metti a bollire l'acqua",
        timer: const Duration(minutes: 10),
      ),
      RecipeStep(
        title: "Preparazione",
        description: "Aggiungi la pasta"
      ),
      RecipeStep(
        title: "Preparazione",
        description: "Scola la pasta",
      ),
      RecipeStep(
        title: "Preparazione",
        description: "Aggiungi il pomodoro e il basilico",
      ),
    ],
  ),
  Recipe(
    title: "Pasta al Pesto",
    tags: [Tag.Primo],
    ingredients: [
      Ingredient(
        name: "Pasta",
        quantity: 100,
        unit: "g",
      ),
      Ingredient(
        name: "Pesto",
        quantity: 50,
        unit: "g",
      ),
    ],
    steps: [
      RecipeStep(
        title: "Preparazione",
        description: "Metti a bollire l'acqua",
        timer: const Duration(minutes: 10),
      ),
      RecipeStep(
        title: "Preparazione",
        description: "Aggiungi la pasta"
      ),
      RecipeStep(
        title: "Preparazione",
        description: "Scola la pasta",
      ),
      RecipeStep(
        title: "Preparazione",
        description: "Aggiungi il pesto",
      ),
    ],
  ),
  Recipe(
    title: "Pasta alla Carbonara",
    tags: [Tag.Primo],
    ingredients: [
      Ingredient(
        name: "Pasta",
        quantity: 100,
        unit: "g",
      ),
      Ingredient(
        name: "Uova",
        quantity: 2,
        unit: "pz",
      ),
      Ingredient(
        name: "Pancetta",
        quantity: 50,
        unit: "g",
      ),
    ],
    steps: [
      RecipeStep(
        title: "Preparazione",
        description: "Metti a bollire l'acqua",
        timer: const Duration(minutes: 10),
      ),
      RecipeStep(
        title: "Preparazione",
        description: "Aggiungi la pasta"
      ),
      RecipeStep(
        title: "Preparazione",
        description: "Scola la pasta",
      ),
      RecipeStep(
        title: "Preparazione",
        description: "Aggiungi le uova e la pancetta",
      ),
    ],
  ),
];
