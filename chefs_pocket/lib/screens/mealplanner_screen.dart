import 'package:chefs_pocket/components/calendar.dart';
import 'package:flutter/material.dart';

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
              setState(( ) {
                showWeek = !showWeek;

              });
            },
          ),
        ],
      ),
      body: Container(
        child:  Calendar( showWeek: showWeek ),
          
        ),
      
    );
  }
}



