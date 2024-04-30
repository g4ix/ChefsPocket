import 'package:chefs_pocket/components/recipe_card.dart';
import 'package:chefs_pocket/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //prova per poter vedere il widget card
  List<Recipe> recipes = [
    Recipe(title: "Pasta al pomodoro", rating: 4, portions: 2),
    Recipe(title: "Pasta al pomodoro", rating: 4, portions: 2),
    Recipe(title: "Pasta al pomodoro", rating: 4, portions: 2),
  ];
  //fine prova

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("../assets/homescreen.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Benvenuto", style: Theme.of(context).textTheme.titleLarge),
              Text("Pronto, Set, Gusto!",
                  style: Theme.of(context).textTheme.titleMedium),
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
                    onPressed: () {},
                    icon: Icon(MdiIcons.chevronLeft),
                    iconSize: 50,
                    color: Color(0xFF557F9F),
                  ),
                  Text("Pranzo",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium), //dovrà essere una variabile che cambia dinamicamente
                  IconButton(
                    onPressed: () {},
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
                    RecipeCard(recipe: recipes[0]),
                    RecipeCard(recipe: recipes[0]),
                    RecipeCard(
                        recipe: recipes[0]) //dovrà essere una lista di ricette
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
