import 'package:chefs_pocket/models/recipe.dart';

class Day {
  DateTime? date;
  List<Recipe> breakfast = [];
  List<Recipe> lunch = [];
  List<Recipe> dinner = [];
  List<Recipe> snacks = [];
  String notesOfDay = "";

  Day({
    this.date ,
    this.breakfast = const [],
    this.lunch = const [],
    this.dinner = const [],
    this.snacks = const [],
    this.notesOfDay = "",
  });
}
