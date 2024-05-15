import 'package:chefs_pocket/models/directory.dart';
import 'package:flutter/material.dart';

class DirectoryManager extends ChangeNotifier {
  final List<Directory> _directories = <Directory>[];

  List<Directory> get directory => List.unmodifiable(_directories);

  void deleteItem(int index) {
    _directories.removeAt(index);
    notifyListeners();
  }

  void addItem(Directory item) {
    _directories.add(item);
    notifyListeners();
  }

  void updateItem(Directory item, int index) {
    _directories[index] = item;
    notifyListeners();
  }
}