// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:chefs_pocket/models/recipe.dart';
import 'package:chefs_pocket/models/recipe_step.dart';
import 'package:chefs_pocket/models/section.dart';

//import dotted border
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';

import '../config.dart';
import '../manager/recipe_manager.dart'; // Import RecipeManager
import '../models/ingredient.dart';
import '../models/recipe_step.dart';

class RecipeCreationPage extends StatefulWidget {
  Recipe recipe = Recipe();

  @override
  _RecipeCreationPageState createState() => _RecipeCreationPageState();
}

class _RecipeCreationPageState extends State<RecipeCreationPage> {
  final _formKey = GlobalKey<FormState>();

  

  String _titleController = '';
  final _images = <String>[];
  double _rating = 0;
  int _portions = 1;

  List<Ingredient> _ingredients = [
    Ingredient(name: '', quantity: 0, unit: ''),
  ];
  List<RecipeStep> _steps = [];
  int _selectedHour = 0;
  int _selectedMinute = 0;
  final List<Tag> _selectedTags = [];
  bool _useEUUnits = true;

  final recipeManager = RecipeManager(); // Create an instance of RecipeManager

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    await _picker.pickImage(source: ImageSource.gallery);
  }
  Map<Ingredient, TextEditingController> ingredientControllers = {};

@override
void initState() {
  super.initState();
  _ingredients.forEach((ingredient) {
    final controller = TextEditingController(text: ingredient.quantity.toString());
    controller.addListener(() {
      setState(() {
        ingredient.quantity = double.parse(controller.text);
      });
    });
    ingredientControllers[ingredient] = controller;
  });
}

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
              recipeManager
                  .addRecipe(widget.recipe); // Add the recipe to the list
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            buildTitleInput(),
            SizedBox(height: 10),
            buildImageUploadContainer(),
            SizedBox(height: 10),
            buildRatingAndToggle(),
            SizedBox(height: 10),
            buildIngredientsAndPortions(),
            SizedBox(height: 10),
            buildProcedure(),
            SizedBox(height: 10),
            buildTotalTime(),
            SizedBox(height: 10),
            buildTags(),
          ],
        ),
      ),
    );
  }

  Widget buildTitleInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Titolo',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Color(0xFF557F9F), // Specify the desired color
              ),
        ),
        SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
              borderRadius: BorderRadius.circular(
                  10.0), // make this the same or smaller than the borderRadius for enabledBorder and focusedBorder
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF557F9F), width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            hintStyle: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey),
            hintText: 'Inserisci il titolo',
          ),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14, // Decrease the font size
              ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Inserisci un titolo';
            }
            return null;
          },
          onChanged: (value) =>
              widget.recipe.setTitle(value), // Update recipe title
        ),
      ],
    );
  }

  Widget buildImageUploadContainer() {
    return GestureDetector(
      onTap: _pickImage,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DottedBorder(
          padding: EdgeInsets.all(0),
          radius: Radius.circular(10),
          color: Color(0xFF557F9F),
          dashPattern: [5, 5],
          borderType: BorderType.RRect,
          strokeWidth: 2,
          child: Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: Color(0xFF557F9F).withOpacity(0.2),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Color(0xFF557F9F).withOpacity(0.2)),
            ),
            child: Center(
              child: _images.isEmpty
                  ? Icon(Icons.add_a_photo, color: Color(0xFF557F9F))
                  : Image.file(
                      File(_images.first),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRatingAndToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Voto',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Color(0xFF557F9F), // Specify the desired color
                        ),
                  ),
                  SizedBox(width: 8),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: MediaQuery.of(context).size.width /
                        15, // Set the size of the stars
                    itemPadding: EdgeInsets.symmetric(
                        horizontal:
                            0), // Decrease the itemPadding value to make the stars closer
                    itemBuilder: (context, _) => Icon(Icons.star,
                        color: Color(0xFF557F9F),
                        size: 10), // Set the size of the stars
                    onRatingUpdate: (rating) {
                      widget.recipe
                          .setRating(rating.toInt()); // Update recipe rating
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('US', style: Theme.of(context).textTheme.bodyMedium),
            Switch(
              value: _useEUUnits,
              onChanged: (value) {
                // logica per cambiare tra EU e US
                setState(() {
                  _useEUUnits = value;
                  if (_useEUUnits) {
                    for (int i = 0; i < _ingredients.length; i++) {
                       _ingredients[i] = _ingredients[i].convertToEuunits();
                        ingredientControllers[_ingredients[i]]!.text = _ingredients[i].quantity.toString();
                    }
                  } else {
                   for (int i = 0; i < _ingredients.length; i++) {
                       _ingredients[i] =_ingredients[i].convertToUsunits();
                      ingredientControllers[_ingredients[i]]!.text = _ingredients[i].quantity.toString();

                    }
                  }
                });
              },
              activeTrackColor: Color(0xFF557F9F),
              activeColor: Colors.white,
              inactiveTrackColor: Color(0xFF557F9F),
              inactiveThumbColor: Colors.white,
              thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                (states) {
                  return null; // Torna al tuo codice qui
                },
              ),
            ),
            Text('EU', style: Theme.of(context).textTheme.bodyMedium),
          ],
        )
      ],
    );
  }

  Widget buildIngredientsAndPortions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredienti',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Color(0xFF557F9F), // Specify the desired color
              ),
        ),
        SizedBox(height: 5),
        Column(
          children: _ingredients.map((ingredient) {
           
            return Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF557F9F), width: 1.0),
                          borderRadius: BorderRadius.circular(
                              10.0), // make this the same or smaller than the borderRadius for enabledBorder and focusedBorder
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF557F9F), width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF557F9F), width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey, fontSize: 14),
                        hintText: '500',

                        contentPadding: EdgeInsets.symmetric(
                            vertical: 2), // Decrease the vertical padding
                      ),
                      controller: ingredientControllers[ingredient],
                      
                    ),
                  ),
                  SizedBox(width: 8),
                  SizedBox(
                    width: 70,
                    child: DropdownButtonFormField(
                      borderRadius: BorderRadius.circular(10),
                      value: ingredient.unit,
                      items: ((_useEUUnits) ? euMeasures : usMeasures)
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.grey)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          ingredient.unit = value!;
                        });
                      },
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF557F9F), width: 1.0),
                          borderRadius: BorderRadius.circular(
                              10.0), // make this the same or smaller than the borderRadius for enabledBorder and focusedBorder
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF557F9F), width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF557F9F), width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      isExpanded: false, // Set isExpanded to false
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          ingredient.name = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey),
                        hintText: 'Farina',
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF557F9F), width: 1.0),
                          borderRadius: BorderRadius.circular(
                              10.0), // make this the same or smaller than the borderRadius for enabledBorder and focusedBorder
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF557F9F), width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF557F9F), width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10), // Decrease the vertical padding
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Porzioni',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Color(
                                  0xFF557F9F), // Specify the desired color
                            ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 50,
                        height: 35,
                        child: TextFormField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          keyboardType: TextInputType.number,
                          initialValue: '2', // Set the default value to 2
                          decoration: InputDecoration(
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF557F9F), width: 1.0),
                              borderRadius: BorderRadius.circular(
                                  10.0), // make this the same or smaller than the borderRadius for enabledBorder and focusedBorder
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF557F9F), width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF557F9F), width: 2.0),
                                borderRadius: BorderRadius.circular(10.0)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal:
                                    10), // Adjust the vertical and horizontal padding
                            alignLabelWithHint:
                                true, // Align the label with the input field
                          ),
                          onChanged: (value) {
                            setState(() {
                              this._portions = int.parse(value);
                            });
                            widget.recipe.setPortions(
                                int.parse(value)); // Update recipe portions
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  Ingredient ingredient = Ingredient(name: '', quantity: 0, unit: '');
                  _ingredients.add(ingredient);
                  ingredientControllers[ingredient] = TextEditingController();
                });
              },
              child: Text(
                '+ Ingrediente',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
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
      ],
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
        
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width/1.8,
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
                    borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
     
                  });
                },
              ),
            ),
            SizedBox(width: 50),
             IconButton(
                icon: Icon(isTimerSet? Icons.timer : Icons.timer_outlined),
                onPressed: () {
                  setState(() {
                    _addTime();
                  });
                },
            ),
             IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: () {
                  setState(() {
                    widget.recipe.removeStep(widget.recipe.steps.last);
                  });
                },
            ),
          ],
        ),
        Row(
          children: [
            
            Container(
              width : MediaQuery.of(context).size.width/1.8,
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
        
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              widget.recipe.addStep(RecipeStep(description: ''));
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
      ], //fine
    );
  }

  Widget buildTotalTime() {
    return Row(
      children: [
        Text('Tempo totale',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Color(0xFF557F9F), // Specify the desired color
                )),
        SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Ore',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Minuti',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
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
  void _addTime() {
    
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
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                int hours = int.tryParse(hoursController.text) ?? 0;
                int minutes = int.tryParse(minutesController.text) ?? 0;
                int seconds = int.tryParse(secondsController.text) ?? 0;
                // Assuming that `timer` is a property of type Duration in your RecipeStep class
                // And `currentStep` is an instance of RecipeStep
     //  _steps[i].timer = Duration(hours: hours, minutes: minutes, seconds: seconds);
                setState(() {
                  isTimerSet = true;
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

