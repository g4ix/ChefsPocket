

import 'package:chefs_pocket/components/calendar.dart';
import 'package:chefs_pocket/components/meal_planner/add_recipe_square.dart';
import 'package:chefs_pocket/components/meal_planner/clipoval_with_text.dart';
import 'package:chefs_pocket/components/meal_planner/meal_row.dart';
import 'package:chefs_pocket/components/recipe_card.dart';
import 'package:chefs_pocket/components/saved/recipe_saved_element.dart';
import 'package:chefs_pocket/config.dart';
import 'package:chefs_pocket/manager/planner_manager.dart';
import 'package:chefs_pocket/models/day.dart';
import 'package:chefs_pocket/models/recipe.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config.dart';

class MealPlannerScreen extends StatefulWidget {
  @override
  _MealPlannerScreenState createState() => _MealPlannerScreenState();
}

class _MealPlannerScreenState extends State<MealPlannerScreen> {
  bool showWeek = true;
  bool modModify = false;
  DateTime selectedDay = DateTime.now();
  Day selectedMeals = Day();
  List<Recipe> toShow = [];

  @override
  void initState() {
    super.initState();
    var plannerManager = Provider.of<PlannerManager>(context, listen: false);
    selectedMeals = plannerManager.days.firstWhere(
        (element) =>
            element.date?.day == DateTime.now().day &&
            element.date?.month == DateTime.now().month &&
            element.date?.year == DateTime.now().year, orElse: () {
      return Day();
    });
    toShow = selectedMeals.breakfast;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => showWeek = true),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            title: Text(
              'Piano Alimentare',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            // leading: IconButton(                       //icona per tornare indietro: SERVE???
            //   icon: Icon(Icons.arrow_back_ios_new),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
            actions: [
              IconButton(
                icon: Icon(Icons.calendar_month_outlined),
                onPressed: () {
                  setState(() {
                    showWeek = !showWeek;
                  });
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Calendar(
                  showWeek: showWeek,
                  onDaySelection: (DateTime date) {
                    var plannerManager =
                        Provider.of<PlannerManager>(context, listen: false);
                    setState(() {
                      selectedMeals = plannerManager.days.firstWhere(
                          (element) =>
                              element.date?.day == date.day &&
                              element.date?.month == date.month &&
                              element.date?.year == date.year, orElse: () {
                        return Day();
                      });
                      toShow = selectedMeals.breakfast;
                    });
                  }), //calendario
              Container(
                //container per la riga dei pasti
                height: 150,
                child: MealRow((String meal) {
                  setState(() {
                    switch (meal) {
                      case 'Colazione':
                        toShow = selectedMeals.breakfast;
                        break;
                      case 'Pranzo':
                        toShow = selectedMeals.lunch;
                        break;
                      case 'Merenda':
                        toShow = selectedMeals.snacks;
                        break;
                      case 'Cena':
                        toShow = selectedMeals.dinner;
                        break;
                      default:
                        toShow = selectedMeals.breakfast;
                    }
                  });
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildReminder(),
              ),
              Expanded(                //container per le ricette
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 200,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    crossAxisCount: 2,
                    // number of items per row
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: modModify ? (toShow.length + 1) : toShow.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == toShow.length && modModify) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AddRecipeSquare(
                          addRecipeToMeal: (Recipe recipe) {
                            setState(() {
                              var plannerManager =
                                  Provider.of<PlannerManager>(context,
                                      listen: false);
                              plannerManager.addRecipeBreakfast(
                                  recipe, selectedMeals.date!);
                              toShow = selectedMeals.breakfast;
                            });
                          },
                        ),
                      ); // Replace with your widget
                    } else {
                      // Otherwise, return the RecipeCard
                      return Container(
                        width: 100,
                        child: RecipeCard(
                            recipe: toShow[index],
                            modModify: modModify,
                            onRemoveRecipe: (Recipe toRemove) {
                              setState(() {
                                var plannerManager =
                                    Provider.of<PlannerManager>(context,
                                        listen: false);
                                int index = toShow.indexWhere(
                                    (element) => element == toRemove);
                                // manca un modo di capire se è selezionato il pranzo o la cena ecc.
                                // si potrebbe creare una variabile mealSelected che contiene il pasto selezionato
                                // e aggiornarla attravero MealRow
                                plannerManager.deleteRecipeBreakfast(
                                    index, selectedMeals.date!);
                              });
                            }),
                      );
                    }
                    //ricette del pranzo di mockday presente in config
                  },
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                modModify = !modModify;
                showWeek = true;
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            child:
                Icon(modModify ? Icons.check : Icons.edit, color: Colors.white),
          )),
    );
  }



Widget buildReminder() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
        color: Color(0xFFFFFED9),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Da ricordare oggi",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              GestureDetector(
                onTap: () {
                  _editNote();
                },
                child: Icon(
                  Icons.edit,
                  color: Color(0xFF557F9F),
                ),
              ),
            ],
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.01), // Aggiungi un po' di spazio tra il titolo e la nota
          Text(
            selectedMeals.notesOfDay, // Modifica questa linea
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }

  void _editNote() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newNote =
             selectedMeals.notesOfDay; // Modifica questa linea
        TextEditingController textEditingController = TextEditingController(
            text:  selectedMeals.notesOfDay); // Modifica questa linea

        return AlertDialog(
          title: Text('Modifica note'),
          content: TextField(
            onChanged: (value) {
              newNote = value;
            },
            controller: textEditingController,
          ),
          actions: [
            TextButton(
              child: Text('Annulla'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Salva'),
              onPressed: () {
                setState(() {
                 selectedMeals.notesOfDay =
                      newNote; // Modifica questa linea
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}