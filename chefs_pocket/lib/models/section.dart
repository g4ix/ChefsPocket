import 'package:chefs_pocket/models/ingredient.dart';
//sezione di ingredienti in una ricetta e della lista della spesa

class Section {
  String title;
  List<Ingredient> ingredients = [];

  Section({
    this.title = "",
    this.ingredients = const [],
  });

}