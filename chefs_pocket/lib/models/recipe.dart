import 'package:chefs_pocket/config.dart';
import 'package:uuid/uuid.dart';
import 'package:chefs_pocket/models/section.dart';
import 'package:chefs_pocket/models/step.dart';

class Recipe {
  String id = const Uuid().v4(); //id per riconoscere la ricetta
  String title = "";
  String imageUrl = "";
  int rating = 0;  //da 1 a 5
  int portions = 0;
  bool showsEuMeasures = true;
  List<Section> section = [];
  List<Step> steps = [];
  Duration totalTime = const Duration(hours: 0, minutes: 0, seconds: 0);
  List<Tag> tags = []; //enum

  Recipe({
    this.title = "",
    this.imageUrl = "",
    this.rating = 0,  
    this.portions = 0,  
    this.showsEuMeasures = true,
    this.section = const [],
    this.steps = const [],
    this.totalTime = const Duration(hours: 0, minutes: 0, seconds: 0),
    this.tags = const [], 
  });

  void convertToEuMeasures() {
    if (!showsEuMeasures) {
      for (var i = 0; i < section.length; i++) {
        for (var j = 0; j < section[i].ingredients.length; j++) {
          section[i].ingredients[j].convertToEuMeasures();
        }
      }
      showsEuMeasures = true;
    }
  }
}

