// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:chefs_pocket/models/section.dart';
import 'package:chefs_pocket/models/recipe.dart';
import 'package:chefs_pocket/models/recipe_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/ingredient.dart';

import '../models/recipe_step.dart';

import '../config.dart';
import '../manager/recipe_manager.dart'; // Import RecipeManager

class RecipeCreationPage extends StatefulWidget {
  Recipe recipe = Recipe();
  Section section = Section();
  RecipeStep step = RecipeStep();

  @override
  _RecipeCreationPageState createState() => _RecipeCreationPageState();
}

class _RecipeCreationPageState extends State<RecipeCreationPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _images = <String>[];
  double _rating = 0.0;
  int _portions = 1;
  final _sections = <Section>[];
  final _steps = <RecipeStep>[];
  int _selectedHour = 0;
  int _selectedMinute = 0;
  final _selectedTags = <Tag>[];
  bool _useEUUnits = true;

  final recipeManager = RecipeManager(); // Create an instance of RecipeManager

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuova ricetta'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titolo
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Titolo',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Inserisci un titolo';
                    }
                    return null;
                  },
                  onChanged: (value) => recipeManager.setTitle(value), // Update recipe title
                ),

                // Immagini
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _images.length + 1,
                        itemBuilder: (context, index) {
                          if (index == _images.length) {
                            return ElevatedButton(
                              onPressed: () async {
                                final image = await ImagePicker().pickImage(
                                  source: ImageSource.gallery,
                                );
                                if (image != null) {
                                  setState(() {
                                    _images.add(image.path);
                                  });
                                  // Update recipe image URL
                                  recipeManager.setImageUrl(image.path);
                                }
                              },
                              child: Icon(Icons.add),
                            );
                          } else {
                            return Image.file(
                              File(_images[index]),
                              width: 100.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),

                // Voto
                SizedBox(height: 16.0),
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: _rating,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 32.0,
                      unratedColor: Colors.grey,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = rating;
                        });
                        recipeManager.setRating(rating.toInt()); // Update recipe rating
                      },
                    ),
                    SizedBox(width: 16.0),
                    DropdownButton<int>(
                      value: _portions,
                      items: [
                        for (int i = 1; i <= 10; i++)
                          DropdownMenuItem(
                            child: Text('$i porzioni'),
                            value: i,
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _portions = value!;
                        });
                        recipeManager.setPortions(value!); // Update recipe portions
                      },
                    ),
                  ],
                ),

                // Ingredienti
                SizedBox(height: 16.0),
                Text('Ingredienti'),
                SizedBox(height: 8.0),
                ListView.builder(
  shrinkWrap: true,
  itemCount: _sections.length,
  itemBuilder: (context, index) {
    final section = _sections[index];
    return Row(
      children: [
        Text(section.title),
        Spacer(),
        IconButton(
          onPressed: () {
            setState(() {
              _sections.removeAt(index);
              recipeManager.removeSection(section); // Update recipe sections
            });
          },
          icon: Icon(Icons.delete),
        ),
      ],
    );
  },
),
SizedBox(height: 8.0),
ElevatedButton(
  onPressed: () {
    final section = Section(title: '');
    final ingredient = Ingredient(name: '', quantity: 0, unit: 'g');
    section.ingredients.add(ingredient);
    setState(() {
      _sections.add(section);
    });
    recipeManager.addSection(section); // Update recipe sections
  },
  child: Text('+ Sezione'),
),
SizedBox(height: 8.0),
ListView.builder(
  shrinkWrap: true,
  itemCount: widget.section.ingredients.length,
  itemBuilder: (context, index2) {
    final ingredient = widget.section.ingredients[index2];
    return Row(
      children: [
        Text('${ingredient.quantity} ${ingredient.unit} ${ingredient.name}'),
        Spacer(),
        IconButton(
          onPressed: () {
            setState(() {
              widget.section.ingredients.removeAt(index2);
              recipeManager.removeIngredient( widget.section, ingredient); // Update recipe ingredients
            });
          },
          icon: Icon(Icons.delete),
        ),
      ],
    );
  },
),

// Procedimento
SizedBox(height: 16.0),
Text('Procedimento'),
SizedBox(height: 8.0),
ListView.builder(
  shrinkWrap: true,
  itemCount: _steps.length,
  itemBuilder: (context, index) {
    final step = _steps[index];
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(step.description),
              if (step.imageUrls != null)
                Image.file(
                  File(widget.step.imageUrls[0]!),
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
              if (step.timer != null)
                Text('Timer: ${step.timer} minuti'),
            ],
          ),
        ),
        PopupMenuButton<StepAction>(
          onSelected: (action) {
            switch (action) {
              case StepAction.setTimer:
                _setTimerForStep(index);
                break;
              case StepAction.removeTimer:
                _removeTimerForStep(index);
                break;
              case StepAction.deleteStep:
                _deleteStep(index);
                break;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: StepAction.setTimer,
              child: Text('Imposta timer'),
            ),
            PopupMenuItem(
              value: StepAction.removeTimer,
              child: Text('Rimuovi timer'),
            ),
            PopupMenuItem(
              value: StepAction.deleteStep,
              child: Text('Elimina step'),
            ),
          ],
        ),
      ],
    );
  },
),
ElevatedButton(
  onPressed: () {
    setState(() {
      _steps.add(RecipeStep(description: ''));
    });
    recipeManager.addStep(RecipeStep(description: '')); // Update recipe steps
  },
  child: Text('+ Step'),
),

// Tempo totale
SizedBox(height: 16.0),
Row(
  children: [
    DropdownButton<int>(
      value: _selectedHour,
      items: [
        for (int i = 0; i <= 24; i++)
          DropdownMenuItem(
            child: Text('$i ore'),
            value: i,
          ),
      ],
      onChanged: (value) {
        setState(() {
          _selectedHour = value!;
          recipeManager.setDuration(Duration(hours: value!)); // Update recipe duration
        });
      },
    ),
    SizedBox(width: 16.0),
    DropdownButton<int>(
  value: _selectedMinute,
  items: [
    for (int i = 0; i <= 60; i++)
      DropdownMenuItem(
        child: Text('$i minuti'),
        value: i,
      ),
  ],
  onChanged: (value) {
    setState(() {
      _selectedMinute = value!;
      recipeManager.setDuration(Duration(minutes: value!)); // Update recipe duration
    });
  },
),
  ],
),

// Tag
SizedBox(height: 16.0),
Wrap(
  spacing: 8.0,
  children: _selectedTags.map((tag) => Chip(
    label: Text(tag.name),
    onDeleted: () {
      setState(() {
        _selectedTags.remove(tag);
        recipeManager.setTags(_selectedTags); // Update recipe tags
      });
    },
  )).toList(),
),
ElevatedButton(
  onPressed: () async {
    final newTag = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Aggiungi tag'),
        content: TextField(
          controller: TextEditingController(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, null);
            },
            child: Text('Annulla'),
          ),
          TextButton(
            onPressed: () {
              final tag = Navigator.pop(context) as Tag;
              if (tag != null) {
                setState(() {
                  _selectedTags.add(tag);
                  recipeManager.setTags(_selectedTags); // Update recipe tags
                });
              }
            },
            child: Text('Aggiungi'),
          ),
        ],
      ),
    );
  },
  child: Text('Aggiungi tag'),
),

// Pulsante per salvare la ricetta
SizedBox(height: 16.0),
ElevatedButton(
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      final recipe = recipeManager.recipe; // Get the updated recipe from RecipeManager
      recipe.sections = _sections; // Update recipe sections with the current state
      recipe.steps = _steps; // Update recipe steps with the current state

      // Save the recipe to your storage mechanism
      // ...

      Navigator.pop(context);
    }
  },
  child: Text('Salva ricetta'),
),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setTimerForStep(int index) {
    // Implementare la logica per impostare il timer per lo step
  }

  void _removeTimerForStep(int index) {
    // Implementare la logica per rimuovere il timer per lo step
  }

  void _deleteStep(int index) {
    setState(() {
      _steps.removeAt(index);
      recipeManager.removeStep(_steps[index]); // Update recipe steps
    });
  }
}

enum StepAction { setTimer, removeTimer, deleteStep }
