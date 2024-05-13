import 'package:chefs_pocket/components/calendar.dart';
import 'package:chefs_pocket/components/meal_planner/clipoval_with_text.dart';
import 'package:chefs_pocket/components/meal_planner/meal_row.dart';
import 'package:chefs_pocket/components/recipe_card.dart';
import 'package:chefs_pocket/components/saved/recipe_saved_element.dart';
import 'package:chefs_pocket/config.dart';
import 'package:flutter/material.dart';

import '../config.dart';

class MealPlannerScreen extends StatefulWidget {
  @override
  _MealPlannerScreenState createState() => _MealPlannerScreenState();
}

class _MealPlannerScreenState extends State<MealPlannerScreen> {
  bool showWeek = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Piano Alimentare',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
          Calendar(showWeek: showWeek),
          Container(
            height: 150,
            child: MealRow(),
          ),
          Expanded(
            // height: MediaQuery.of(context).size.height - 450,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 200,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                crossAxisCount: 2, // number of items per row
              ),
              scrollDirection: Axis.vertical,
              itemCount: mockDays[1].lunch.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    width: 100,
                    child: RecipeCard(
                        recipe: mockDays[1].lunch[
                            index])); //ricette del pranzo di mockday presente in config
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed action here
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.edit, color: Colors.white),
      )
    );
  }
}
