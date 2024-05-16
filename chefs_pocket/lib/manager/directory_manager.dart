import 'package:chefs_pocket/config.dart';
import 'package:chefs_pocket/models/directory.dart';
import 'package:flutter/material.dart';
import 'package:chefs_pocket/models/recipe.dart';

class DirectoryManager extends ChangeNotifier {
  final List<Directory> _directories = mockDirectories;
  

  List<Directory> get directory => List.unmodifiable(_directories);

  void deleteItem(int index) {
    _directories.removeAt(index);
    notifyListeners();
  }

  void addItem(Directory item) {
    _directories.add(item);
    notifyListeners();
  }

  void addRecipeToDirectory(Directory dir, Recipe recipe) {
    dir.recipes.add(recipe);
    notifyListeners();
  }

  void updateItem(Directory item, int index) {
    _directories[index] = item;
    notifyListeners();
  }
}