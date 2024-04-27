//classe per la cartella che contiene diverse ricette
import 'package:chefs_pocket/models/recipe.dart';

class Directory {
  String name = "";
  List<Recipe> recipes = []; //o lista UUID da cui poi ricavo le ricette?
  String imageUrl = ""  ;

  Directory({
    this.name = "", 
    this.recipes = const [],
    this.imageUrl = ""
    });
}