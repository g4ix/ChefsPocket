import 'package:chefs_pocket/models/directory.dart';
import 'package:flutter/material.dart';

class DirectoryManager extends ChangeNotifier {
  final List<Directory> _directory = <Directory>[];

  List<Directory> get directory => List.unmodifiable(_directory);

  void deleteItem(int index) {
    _directory.removeAt(index);
    notifyListeners();
  }

  void addItem(Directory item) {
    _directory.add(item);
    notifyListeners();
  }

  void updateItem(Directory item, int index) {
    _directory[index] = item;
    notifyListeners();
  }
}