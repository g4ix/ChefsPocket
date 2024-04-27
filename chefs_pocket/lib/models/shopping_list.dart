import 'package:chefs_pocket/models/ingredient.dart';

class ShoppingList {
  String title = "";
  List<Ingredient> elements = []; //non so se mettere list di sezioni potrebbe essere complesso quando si aggiungono nuovi ingredienti
  
  String notes = "";

  ShoppingList({
    this.title = "",
    this.elements = const [],
    this.notes = "",
    });
}