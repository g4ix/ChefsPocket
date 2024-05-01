import 'package:chefs_pocket/models/day.dart';
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
    imageUrl: "../assets/recipes/pasta_pomodoro.jpg",
    tags: [Tag.Primo],
    rating: 3,
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
    imageUrl: "../assets/recipes/pasta_pesto.jpg",
    rating: 2,
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
    imageUrl: "../assets/recipes/pasta_carbonara.jpg",
    rating: 4,
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

List<Day> mockDays = [
  Day(
    date: DateTime.now(),
    lunch: mockRecipies,
    dinner: mockRecipies,
    snacks: mockRecipies,
    breakfast: mockRecipies,
  ),
  Day(
    date: DateTime.now().add(const Duration(days: 1)),
    lunch: mockRecipies,
    dinner: mockRecipies,
    snacks: mockRecipies,
    breakfast: mockRecipies,
  ),
  Day(
    date: DateTime.now().add(const Duration(days: 2)),
    lunch: mockRecipies,
    dinner: mockRecipies,
    snacks: mockRecipies,
    breakfast: mockRecipies,
  ),
  Day(
    date: DateTime.now().add(const Duration(days: 3)),
    lunch: mockRecipies,
    dinner: mockRecipies,
    snacks: mockRecipies,
    breakfast: mockRecipies,
  ),
  Day(
    date: DateTime.now().add(const Duration(days: 4)),
    lunch: mockRecipies,
    dinner: mockRecipies,
    snacks: mockRecipies,
    breakfast: mockRecipies,
  ),
  Day(
    date: DateTime.now().add(const Duration(days: 5)),
    lunch: mockRecipies,
    dinner: mockRecipies,
    snacks: mockRecipies,
    breakfast: mockRecipies,
  ),
  Day(
    date: DateTime.now().add(const Duration(days: 6)),
    lunch: mockRecipies,
    dinner: mockRecipies,
    snacks: mockRecipies,
    breakfast: mockRecipies,
  ),
];