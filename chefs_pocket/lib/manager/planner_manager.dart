import 'package:chefs_pocket/config.dart';
import 'package:chefs_pocket/models/day.dart';
import 'package:chefs_pocket/models/recipe.dart';
import 'package:flutter/material.dart';

class PlannerManager extends ChangeNotifier {
  List<Day> _days = [
    Day(
        date: DateTime.now(),
        breakfast: [mockRecipes[0], mockRecipes[1], mockRecipes[2]],
        lunch: [mockRecipes[1]],
        dinner: [mockRecipes[2]],
        snacks: [mockRecipes[2]]),
    mockDays[1],
    mockDays[2],
  ];

  List<Day> get days => _days;

  //funzioni per rimuovere/aggiungere ricette ai pasti di un particolare giorno
  //non so se deve essere fatto qua.
  void addRecipe(DateTime date, String meal, Recipe item) {
    // sarebbe necessario controllare che la ricetta non sia già presente
    switch (meal) {
      case 'Colazione':
        addRecipeBreakfast(item, date);
        break;
      case 'Pranzo':
        addRecipeLunch(item, date);
        break;
      case 'Cena':
        addRecipeDinner(item, date);
        break;
      case 'Merenda':
        addRecipeSnacks(item, date);
        break;
    }
  }

  void deleteRecipe(int index, DateTime date, String meal) {
    switch (meal) {
      case 'Colazione':
        deleteRecipeBreakfast(index, date);
        break;
      case 'Pranzo':
        deleteRecipeLunch(index, date);
        break;
      case 'Cena':
        deleteRecipeDinner(index, date);
        break;
      case 'Merenda':
        deleteRecipeSnacks(index, date);
        break;
    }
  }

  //delete a recipe from lunch array
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
    if (indexDay == -1) {
      _days.add(Day(date: date, lunch: [item]));
      notifyListeners();
      return;
    } else {
      _days[indexDay].lunch.add(item);
      notifyListeners();
    }
  }

  void addRecipeBreakfast(Recipe item, DateTime date) {
    //search the object day with the date variable equals to the date parameter
    int indexDay = _days.indexWhere((element) => element.date == date);
    if (indexDay == -1) {
      _days.add(Day(date: date, breakfast: [item]));
      notifyListeners();
      return;
    } else {
      _days[indexDay].breakfast.add(item);
      notifyListeners();
    }
  }

  void addRecipeDinner(Recipe item, DateTime date) {
    //search the object day with the date variable equals to the date parameter
    int indexDay = _days.indexWhere((element) => element.date == date);
    if (indexDay == -1) {
      _days.add(Day(date: date, dinner: [item]));
      notifyListeners();
      return;
    } else {
      _days[indexDay].dinner.add(item);
      notifyListeners();
    }
  }

  void addRecipeSnacks(Recipe item, DateTime date) {
    //search the object day with the date variable equals to the date parameter
    int indexDay = _days.indexWhere((element) => element.date == date);
    if (indexDay == -1) {
      _days.add(Day(date: date, snacks: [item]));
      notifyListeners();
      return;
    } else {
      _days[indexDay].snacks.add(item);
      notifyListeners();
    }
  }

  void updateNotes(String notes, DateTime date) {
    //search the object day with the date variable equals to the date parameter
    int indexDay = _days.indexWhere((element) => element.date == date);
    _days[indexDay].notesOfDay = notes;
    notifyListeners();
  }

  //non so se mancano funzioni per aggiungere o togliere direttamente date
  void updateItem(Day item, int index) {
    _days[index] = item;
    notifyListeners();
  }

  //togliere e aggiungere un giorno dalla lista dei giorni con ricette
  void deleteItem(int index) {
    _days.removeAt(index);
    notifyListeners();
  }

  void addItem(Day item) {
    _days.add(item);
    notifyListeners();
  }
}
