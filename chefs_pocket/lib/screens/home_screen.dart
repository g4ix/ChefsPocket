import 'package:chefs_pocket/components/recipe_card.dart';
import 'package:chefs_pocket/components/reminder_note.dart';
import 'package:chefs_pocket/config.dart';
import 'package:chefs_pocket/manager/planner_manager.dart';
import 'package:chefs_pocket/models/day.dart';
import 'package:chefs_pocket/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  List<String> meals = ['Colazione', 'Pranzo', 'Merenda', 'Cena'];
  Day todayMeals = Day();
  List<Recipe> toShow = [];

  List<Recipe> selectRecipies(String meal) {
    switch (meal) {
      case 'Colazione':
        print('C');
        return todayMeals.breakfast;
      case 'Pranzo':
        print('P');
        return todayMeals.lunch;
      case 'Merenda':
        print('M');
        return todayMeals.snacks;
      case 'Cena':
        print('Ce');
        return todayMeals.dinner;
      default:
        return [];
    }
  }

  @override
  void initState() {
    super.initState();
    var plannerManager = Provider.of<PlannerManager>(context, listen: false);
    todayMeals = plannerManager.days.firstWhere(
        (element) =>
            element.date?.day == DateTime.now().day &&
            element.date?.month == DateTime.now().month &&
            element.date?.year == DateTime.now().year, orElse: () {
      return Day();
    });
    setState(() {
      toShow = todayMeals.breakfast;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlannerManager>(
      builder: (context, plannerManager, child) {
        todayMeals = plannerManager.days.firstWhere(
            (element) =>
                element.date?.day == DateTime.now().day &&
                element.date?.month == DateTime.now().month &&
                element.date?.year == DateTime.now().year, orElse: () {
          return Day();
        });
        return SafeArea(
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage("assets/background/homescreen_background.png"),
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                  scale: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Benvenuto",
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.left),
                    Text("Pronto, Set, Gusto!",
                        style: Theme.of(context).textTheme.titleMedium),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    ReminderNote(notesOfDay: todayMeals.notesOfDay),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              index = (index - 1 + meals.length) % meals.length;
                              toShow = selectRecipies(meals[index]);
                              print(toShow);
                            });
                          },
                          icon: Icon(MdiIcons.chevronLeft),
                          iconSize: 50,
                          color: Color(0xFF557F9F),
                        ),
                        Text(meals[index],
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium), //dovrà essere una variabile che cambia dinamicamente
                        IconButton(
                          onPressed: () {
                            setState(() {
                              index = (index + 1 + meals.length) % meals.length;
                              toShow = selectRecipies(meals[index]);
                              print(toShow);
                            });
                          },
                          icon: Icon(MdiIcons.chevronRight),
                          iconSize: 50,
                          color: Color(0xFF557F9F),
                        ),
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: (toShow.length > 0)
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: toShow.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return RecipeCard(
                                    recipe: toShow[index],
                                    modModify: false,
                                  );
                                },
                              )
                            : Text(
                                'Nessuna ricetta selezionata per questo pasto',
                                style: Theme.of(context).textTheme.bodyMedium,
                                textAlign: TextAlign.center)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
