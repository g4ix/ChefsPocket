import 'package:flutter/rendering.dart';

class RecipeStep {
  String description = "";
  List<String> imageUrls = [];
  String title = "";
  Duration timer = const Duration(hours: 0, minutes: 0, seconds: 0);
  bool isTimerSet = false;
  RecipeStep(
      {this.description = "",
      this.imageUrls = const [],
      this.title = "",
      this.timer = const Duration(hours: 0, minutes: 0, seconds: 0),
      this.isTimerSet = false
      });
   
}
