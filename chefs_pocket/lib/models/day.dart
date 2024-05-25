import 'package:chefs_pocket/models/recipe.dart';

class Day {
  DateTime? date;
  List<Recipe> breakfast;
  List<Recipe> lunch;
  List<Recipe> dinner;
  List<Recipe> snacks;
  String notesOfDay;

  Day({
    this.date,
    List<Recipe>? breakfast,
    List<Recipe>? lunch,
    List<Recipe>? dinner,
    List<Recipe>? snacks,
    this.notesOfDay = "",
  })  : this.breakfast = breakfast ?? [],
        this.lunch = lunch ?? [],
        this.dinner = dinner ?? [],
        this.snacks = snacks ?? [];
}
