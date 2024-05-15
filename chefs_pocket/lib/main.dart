import 'package:chefs_pocket/app_theme.dart';
import 'package:chefs_pocket/components/bottom_bar.dart';
import 'package:chefs_pocket/manager/directory_manager.dart';
import 'package:chefs_pocket/manager/grocery_manager.dart';
import 'package:chefs_pocket/manager/planner_manager.dart';
import 'package:chefs_pocket/manager/recipe_manager.dart';
import 'package:chefs_pocket/models/grocery_list.dart';
import 'package:chefs_pocket/screens/grocery_list.dart';
import 'package:chefs_pocket/screens/home_screen.dart';
import 'package:chefs_pocket/screens/mealplanner_screen.dart';
import 'package:chefs_pocket/screens/recipe_creation.dart';
import 'package:chefs_pocket/screens/recipe_page.dart';
import 'package:chefs_pocket/screens/saved.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  //funzione per mettere il calendario in italiano
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final PlannerManager _plannerManager = PlannerManager();
  final DirectoryManager _directoryManager = DirectoryManager();
  final GroceryManager _groceryManager = GroceryManager();
  final RecipeManager _recipeManager = RecipeManager();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlannerManager>.value(value: _plannerManager),
        ChangeNotifierProvider<DirectoryManager>.value(
            value: _directoryManager),
        ChangeNotifierProvider<GroceryManager>.value(value: _groceryManager),
        ChangeNotifierProvider<RecipeManager>.value(value: _recipeManager),
      ],
      child: MaterialApp(
        title: "Chef's Recipe", //titolo della pagina
        theme: ChefsPocketTheme.light(), //tema della pagina
        home: const MyHomePage(title: "Chef's Pocket"), //pagina iniziale
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  final List<Widget> _pages = <Widget>[
    HomeScreen(),
    SavedScreen(),
    RecipeCreationPage(),
    MealPlannerScreen(),
    GroceryListScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //titolo della pagina accessibile grazie a "widget" che permette di accedere ad altre classi
        body: IndexedStack(
          index: currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          activeIconIndex: currentIndex,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
        ));
  }
}
