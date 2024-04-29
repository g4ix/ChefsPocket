import 'package:chefs_pocket/config.dart';
import 'package:uuid/uuid.dart';
import 'package:chefs_pocket/models/section.dart';
import 'package:chefs_pocket/models/recipe_step.dart';

class Recipe {
  String id = const Uuid().v4(); //id per riconoscere la ricetta
  String title = "";
  String imageUrl = "";
  int rating = 0;  //da 1 a 5
  int portions = 0;
  bool showsEuMeasures = true;
  List<Section> sections = [];
  List<RecipeStep> steps = [];
  Duration totalTime = const Duration(hours: 0, minutes: 0, seconds: 0);
  List<Tag> tags = []; //enum

  Recipe({
    this.title = "",
    this.imageUrl = "",
    this.rating = 0,  
    this.portions = 0,  
    this.showsEuMeasures = true,
    this.sections = const [],
    this.steps = const [],
    this.totalTime = const Duration(hours: 0, minutes: 0, seconds: 0),
    this.tags = const [], 
  });

  void convertToEuMeasures() {
    if (!showsEuMeasures) {
      for (var i = 0; i < sections.length; i++) {
        for (var j = 0; j < sections[i].ingredients.length; j++) {
          sections[i].ingredients[j].convertToEuunits();
        }
      }
      showsEuMeasures = true;
    }
  }

  void convertToUsMeasures() {
    if (showsEuMeasures) {
      for (var i = 0; i < sections.length; i++) {
        for (var j = 0; j < sections[i].ingredients.length; j++) {
          sections[i].ingredients[j].convertToUsunits();
        }
      }
      showsEuMeasures = false;
    }
  }
}

