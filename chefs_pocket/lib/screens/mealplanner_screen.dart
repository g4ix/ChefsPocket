import 'package:chefs_pocket/components/calendar.dart';
import 'package:chefs_pocket/components/meal_planner/clipoval_with_text.dart';
import 'package:chefs_pocket/components/meal_planner/meal_row.dart';
import 'package:chefs_pocket/components/recipe_card.dart';
import 'package:chefs_pocket/components/saved/recipe_saved_element.dart';
import 'package:chefs_pocket/config.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../config.dart';

class MealPlannerScreen extends StatefulWidget {
  @override
  _MealPlannerScreenState createState() => _MealPlannerScreenState();
}

class _MealPlannerScreenState extends State<MealPlannerScreen> {
  bool showWeek = true;
  bool modModify = false;

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
              Calendar(showWeek: showWeek), //calendario
              Container(
                //container per la riga dei pasti
                height: 150,
                child: MealRow(),
              ),
              Expanded(
                //container per le ricette
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 200,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    crossAxisCount: 2,
                    // number of items per row
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: modModify
                      ? (mockDays[1].lunch.length + 1)
                      : mockDays[1].lunch.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == mockDays[1].lunch.length && modModify) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: DottedBorder(
                            padding: EdgeInsets.all(0),
                            radius: Radius.circular(10),
                            color: Color(0xFF557F9F),
                            dashPattern: [5, 5],
                            borderType: BorderType.RRect,
                            strokeWidth: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF557F9F).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Color(0xFF557F9F).withOpacity(0.2)),
                              ),
                              child: Center(
                                child: Icon(Icons.add,
                                    color: Color(0xFF557F9F), size: 30),
                              ),
                            ),
                          ),
                        ),
                      ); // Replace with your widget
                    } else {
                      // Otherwise, return the RecipeCard
                      return Container(
                        width: 100,
                        child: RecipeCard(
                            recipe: mockDays[1].lunch[index],
                            modModify: modModify),
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
}
