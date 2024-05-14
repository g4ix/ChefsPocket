import 'package:chefs_pocket/components/bottom_bar.dart';
import 'package:chefs_pocket/components/recipe_page/ingredient_section.dart';
import 'package:chefs_pocket/components/recipe_page/step_section.dart';
import 'package:chefs_pocket/config.dart';
import 'package:chefs_pocket/models/grocery_list.dart';
import 'package:chefs_pocket/models/recipe.dart';
import 'package:chefs_pocket/screens/grocery_list.dart';
import 'package:chefs_pocket/screens/home_screen.dart';
import 'package:chefs_pocket/screens/mealplanner_screen.dart';
import 'package:chefs_pocket/screens/recipe_creation.dart';
import 'package:chefs_pocket/screens/saved.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RecipePage extends StatefulWidget {
  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  Recipe recipe = mockRecipes[2];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.edit_calendar_rounded),
              onPressed: () {},
            ),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.bookmark_add_rounded)),
            IconButton(onPressed: () {}, icon: Icon(Icons.edit))
          ],
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(-1.25, -1.01),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    recipe.imageUrl,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.96, -0.62),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5), // Shadow color
                          spreadRadius: 20, // Spread radius
                          blurRadius: 20, // Blur radius
                          offset: Offset(0, 3), // Offset
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          recipe.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                                // shadows: [
                                //   Shadow(
                                //     offset: Offset(2.0, 2.0),
                                //     blurRadius: 5.0,
                                //     color: Colors.black,
                                //   ),
                                // ],
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                        ),
                        RatingBarIndicator(
                          rating: recipe.rating.toDouble(),
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 1.01),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(24),
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment(0, 0),
                        child: TabBar(
                          labelColor: Theme.of(context).colorScheme.primary,
                          unselectedLabelColor:
                              Theme.of(context).colorScheme.secondary,
                          labelStyle: Theme.of(context).textTheme.bodyMedium,
                          unselectedLabelStyle: TextStyle(),
                          indicatorColor: Theme.of(context).colorScheme.primary,
                          padding: EdgeInsets.all(4),
                          tabs: [
                            Tab(
                              text: 'Ingredienti',
                            ),
                            Tab(
                              text: 'Procedimento',
                            ),
                          ],
                          //controller: _model.tabBarController,
                          onTap: (i) async {
                            [() async {}, () async {}][i]();
                          },
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          //controller: _model.tabBarController,
                          children: [
                            IngredientSection(),
                            StepSection(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      
      ),
    );
  }
}
