// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:chefs_pocket/components/recipe_creation/image_upload_container.dart';
import 'package:chefs_pocket/components/recipe_creation/ingredient_input.dart';
import 'package:chefs_pocket/components/recipe_creation/ingredient_portion_section.dart';
import 'package:chefs_pocket/components/recipe_creation/rating_and_toggle.dart';
import 'package:chefs_pocket/components/recipe_creation/set_total_time.dart';
import 'package:chefs_pocket/components/recipe_creation/title_input_section.dart';
import 'package:chefs_pocket/models/recipe.dart';
import 'package:chefs_pocket/models/recipe_step.dart';
import 'package:chefs_pocket/models/section.dart';
import 'package:chefs_pocket/screens/recipe_page.dart';
import 'package:chefs_pocket/manager/directory_manager.dart';
import 'package:chefs_pocket/config.dart';
import '../manager/recipe_manager.dart'; // Import RecipeManager
import '../models/ingredient.dart';
import '../models/directory.dart';

//import dotted border
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';

class RecipeCreationPage extends StatefulWidget {
  Recipe recipe = Recipe();

  @override
  _RecipeCreationPageState createState() => _RecipeCreationPageState();
}

class _RecipeCreationPageState extends State<RecipeCreationPage> {
  final _formKey = GlobalKey<FormState>();

  String _titleController = '';
  List<String> _images = [];
  double _rating = 0;
  int _portions = 1;

  List<Ingredient> _ingredients = [
    Ingredient(name: '', quantity: 0, unit: ''),
  ];
  List<RecipeStep> _steps = [
    RecipeStep(title: '', description: ''),
  ];
  int _selectedHour = 0;
  int _selectedMinute = 0;
  List<Tag> _selectedTags = [];
  bool _useEUUnits = true;

  final Directory _recipes = savedRecipesDirectory;

  final recipeManager = RecipeManager(); // Create an instance of RecipeManager
  final directoryManager =
      DirectoryManager(); // Create an instance of DirectoryManager

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    await _picker.pickImage(source: ImageSource.gallery);
  }

  Map<Ingredient, TextEditingController> ingredientControllers = {};

  @override
  void initState() {
    super.initState();
    _ingredients.forEach((ingredient) {
      final controller =
          TextEditingController(text: ingredient.quantity.toString());
      controller.addListener(() {
        setState(() {
          ingredient.quantity = double.parse(controller.text);
        });
      });
      ingredientControllers[ingredient] = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nuova ricetta',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              widget.recipe.ingredients = _ingredients;
              widget.recipe.steps = _steps;
              widget.recipe.tags = _selectedTags;
              recipeManager
                  .addRecipe(widget.recipe); // Add the recipe to the list
              //directoryManager.addRecipeToDirectory(_recipes, widget.recipe);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipePage(recipe: widget.recipe),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            TitleInputSection((value) => widget.recipe.setTitle(value)),
            SizedBox(height: 10),
            ImageUploadContainer(_pickImage, _images),
            SizedBox(height: 10),
            RatingAndToggle(
              onChangedUnits: (value) {
                setState(() {
                  _useEUUnits = value;
                  if (_useEUUnits) {
                    for (int i = 0; i < _ingredients.length; i++) {
                      _ingredients[i].convertToEuunits();
                      ingredientControllers[_ingredients[i]]!.text =
                          _ingredients[i].quantity.toString();
                    }
                  } else {
                    for (int i = 0; i < _ingredients.length; i++) {
                      _ingredients[i].convertToUsunits();
                      ingredientControllers[_ingredients[i]]!.text =
                          _ingredients[i].quantity.toString();
                    }
                  }
                });
              },
              onRatingUpdate: (rating) {
                widget.recipe.setRating(rating.toInt()); // Update recipe rating
              },
              useEuUnits: _useEUUnits,
            ),
            SizedBox(height: 10),
            IngredientPortionSection(
              ingredients: _ingredients,
              remove: (ingredient) {
                setState(() {
                  _ingredients.remove(ingredient);
                  ingredientControllers.remove(ingredient);
                });
              },
              ingredientControllers: ingredientControllers,
              useEuUnits: _useEUUnits,
              recipe: widget.recipe,
              onPortionChange: (value) {
                setState(() {
                  this._portions = int.parse(value);
                });
                widget.recipe
                    .setPortions(int.parse(value)); // Update recipe portions
              },
            ),
            SizedBox(height: 10),
            buildProcedure(),
            SizedBox(height: 10),
            SetTotalTime(
              onChangedHour: (value) {
                setState(() {
                  _selectedHour = int.parse(value);
                  widget.recipe.setTotalTime(Duration(
                      hours: _selectedHour,
                      minutes: _selectedMinute)); // Update recipe total time
                });
              },
              onChangedMinutes: (value) {
                setState(() {
                  _selectedMinute = int.parse(value);
                  widget.recipe.setTotalTime(Duration(
                      hours: _selectedHour,
                      minutes: _selectedMinute)); // Update recipe total time
                });
              },
            ),
            SizedBox(height: 10),
            buildTags(),
          ],
        ),
      ),
    );
  }

  Widget buildProcedure() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          'Procedimento',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Color(0xFF557F9F), // Specify the desired color
              ),
        ),
        ..._steps.map((step) {
          return Column(
            children: [
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.8,
                    height: 25,
                    child: TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey),
                        hintText: 'Titolo',
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF557F9F), width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF557F9F), width: 1.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          step.title = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 15),
                  IconButton(
                    icon: Icon(
                        step.isTimerSet ? Icons.timer : Icons.timer_outlined),
                    onPressed: () {
                      setState(() {
                        _addTime(step);
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _steps.remove(step);
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey),
                        hintText: 'Descrivi i passaggi della ricetta',
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF557F9F), width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF557F9F), width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      height: 167,
                      width: 120,
                      // Set the desired width
                      decoration: BoxDecoration(
                        color: Color(0xFF557F9F).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Color(0xFF557F9F).withAlpha(20),
                        ),
                      ),
                      child: DottedBorder(
                        padding: EdgeInsets.all(0),
                        radius: Radius.circular(5),
                        color: Color(0xFF557F9F),
                        dashPattern: [5, 5],
                        borderType: BorderType.RRect,
                        strokeWidth: 2,
                        child: Center(
                          child: _images.isEmpty
                              ? Icon(
                                  Icons.add_a_photo,
                                  color: Color(0xFF557F9F),
                                )
                              : Image.file(
                                  File(_images.first),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _steps.add(RecipeStep());
                });
              },
              child: Text('Aggiungi step',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF557F9F),
                disabledForegroundColor: Color(0xFFF557F9F),
                disabledBackgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ], //fine
    );
  }

  Widget buildTags() {
    return Column(
      children: [
        buildTitleTag(),
        SizedBox(height: 8),
        buildFilterChips(),
      ],
    );
  }

  Widget buildTitleTag() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text('Tag',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Color(0xFF557F9F), // Specifica il colore desiderato
              )),
    );
  }

  Widget buildFilterChips() {
    return Wrap(
      spacing: 8.0, // Spazio tra le chips
      runSpacing: 10.0, // Spazio tra le righe
      children: Tag.values.map((tag) {
        return FilterChip(
          label: Text(
            tag.toString().replaceAll('Tag.', ''),
            style: TextStyle(
              color: _selectedTags.contains(tag)
                  ? Colors
                      .white // Imposta il colore del testo su bianco se selezionato
                  : Color(
                      0xFF557F9F), // Imposta il colore del testo su blu se non selezionato
            ),
          ),
          selected: _selectedTags.contains(tag),
          selectedColor: Color(0xFF557F9F),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _selectedTags.add(tag);
              } else {
                _selectedTags.remove(tag);
              }
            });
          },
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Color(0xFF557F9F), // Imposta il colore del bordo
              width: 1.0, // Imposta la larghezza del bordo
            ),
            borderRadius:
                BorderRadius.circular(8.0), // Imposta il raggio del bordo
          ),
        );
      }).toList(),
    );
  }

//pop up per aggiungere il timer allo step
  void _addTime(step) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController hoursController = TextEditingController();
        TextEditingController minutesController = TextEditingController();
        TextEditingController secondsController = TextEditingController();
        return AlertDialog(
          title: Text('Imposta il Timer'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: TextField(
                  controller: hoursController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'ore',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: TextField(
                  controller: minutesController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'min',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: TextField(
                  controller: secondsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'sec',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Elimina'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Salva'),
              onPressed: () {
                int hours = int.tryParse(hoursController.text) ?? 0;
                int minutes = int.tryParse(minutesController.text) ?? 0;
                int seconds = int.tryParse(secondsController.text) ?? 0;
                // Assuming that `timer` is a property of type Duration in your RecipeStep class
                // And `currentStep` is an instance of RecipeStep
                //  _steps[i].timer = Duration(hours: hours, minutes: minutes, seconds: seconds);
                setState(() {
                  step.timer = Duration(
                      hours: hours, minutes: minutes, seconds: seconds);
                  step.isTimerSet = true;
                });
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF557F9F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
