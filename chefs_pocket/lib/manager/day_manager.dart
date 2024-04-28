import 'package:chefs_pocket/models/day.dart';
import 'package:chefs_pocket/models/recipe.dart';
import 'package:flutter/material.dart';

class DayManager extends ChangeNotifier {
  final List<Day> _days = <Day>[];

  List<Day> get days => List.unmodifiable(_days);
  
  //funzioni per rimuovere/aggiungere ricette ai pasti di un particolare giorno
  //non so se deve essere fatto qua. 
  
 //delete a recipe fron lunch array
  void deleteRecipeLunch(int index, DateTime date) {
    //search the day with the date
    int indexDay = _days.indexWhere((element) => element.date == date);
    _days[indexDay].lunch.removeAt(index);
    notifyListeners();
  }

  //delete a recipe fron breakfast array
  void deleteRecipeBreakfast(int index, DateTime date) {
    //search the day with the date
    int indexDay = _days.indexWhere((element) => element.date == date);
    _days[indexDay].breakfast.removeAt(index);
    notifyListeners();
  }

  //delete a recipe fron dinner array
  void deleteRecipeDinner(int index, DateTime date) {
    //search the day with the date
    int indexDay = _days.indexWhere((element) => element.date == date);
    _days[indexDay].dinner.removeAt(index);
    notifyListeners();
  }

  //delete a recipe fron snacks array
  void deleteRecipeSnacks(int index, DateTime date) {
    //search the object day with the date variable equals to the date parameter
    int indexDay = _days.indexWhere((element) => element.date == date);
    _days[indexDay].snacks.removeAt(index);
    notifyListeners();
  }

  void addRecipeLunch(Recipe item, DateTime date) {
    //search the object day with the date variable equals to the date parameter
    int indexDay = _days.indexWhere((element) => element.date == date);
    _days[indexDay].lunch.add(item);
    notifyListeners();
  }

  void addRecipeBreakfast(Recipe item, DateTime date) {
    //search the object day with the date variable equals to the date parameter
    int indexDay = _days.indexWhere((element) => element.date == date);
    _days[indexDay].breakfast.add(item);
    notifyListeners();
  }

  void addRecipeDinner(Recipe item, DateTime date) {
    //search the object day with the date variable equals to the date parameter
    int indexDay = _days.indexWhere((element) => element.date == date);
    _days[indexDay].dinner.add(item);
    notifyListeners();
  }

  void addRecipeSnacks(Recipe item, DateTime date) {
    //search the object day with the date variable equals to the date parameter
    int indexDay = _days.indexWhere((element) => element.date == date);
    _days[indexDay].snacks.add(item);
    notifyListeners();
  }
  
  //non so se mancano funzioni per aggiungere o togliere direttamente date 
  void updateItem(Day item, int index) {
    _days[index] = item;
    notifyListeners();
  }
}