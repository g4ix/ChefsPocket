import 'package:chefs_pocket/components/recipe_card.dart';
import 'package:chefs_pocket/config.dart';
import 'package:chefs_pocket/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  static int index = 0;
  static List<String> meals = ['Breakfast', 'Lunch', 'Snack', 'Dinner'];
  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  //prova per poter vedere il widget card
  
  //fine prova

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Expanded(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("../assets/background/homescreen.png"),
              fit: BoxFit.none,
              alignment: Alignment.bottomCenter,
              scale: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Benvenuto", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.left),
                Text("Pronto, Set, Gusto!",style: Theme.of(context).textTheme.titleMedium),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  height: 200,
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
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Note del giorno",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        "Non c'è nulla da ricordare per oggi!",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                    onPressed: () {
                        setState(() {
                          HomeScreen.index = (HomeScreen.index - 1 + HomeScreen.meals.length) % HomeScreen.meals.length;
                        });
                      },
                      icon: Icon(MdiIcons.chevronLeft),
                      iconSize: 50,
                      color: Color(0xFF557F9F),
                    ),
                    Text(HomeScreen.meals[HomeScreen.index] ,
                        style: Theme.of(context).textTheme.titleMedium), //dovrà essere una variabile che cambia dinamicamente
                    IconButton(
                      onPressed: () {
                        setState(() {
                         HomeScreen.index = (HomeScreen.index + 1 + HomeScreen.meals.length) % HomeScreen.meals.length;
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
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      RecipeCard(recipe: mockRecipies[0]),
                      RecipeCard(recipe: mockRecipies[1]),
                      RecipeCard(recipe: mockRecipies[2]) //dovrà essere una lista di ricette
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
