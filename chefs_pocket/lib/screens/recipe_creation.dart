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
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class RecipeCreationPage extends StatefulWidget {
  Recipe recipe = Recipe();
  RecipeStep step = RecipeStep();

  @override
  _RecipeCreationPageState createState() => _RecipeCreationPageState();
}

class _RecipeCreationPageState extends State<RecipeCreationPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _images = <String>[];
  double _rating = 0;
  int _portions = 1;
  final _steps = <RecipeStep>[];
  int _selectedHour = 0;
  int _selectedMinute = 0;
  final _selectedTags = <Tag>[];
  bool _useEUUnits = true;

  final recipeManager = RecipeManager(); // Create an instance of RecipeManager

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    await _picker.pickImage(source: ImageSource.gallery);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nuova ricetta',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            buildTitleInput(),
            buildImageUploadContainer(),
            buildRatingAndPortions(),
            SizedBox(height: 15),
            buildIngredients(),
            SizedBox(height: 15),
            buildProcedure(),
            SizedBox(height: 15),
            buildTotalTime(),
            SizedBox(height: 15),
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
        SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Inserisci il titolo',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF557F9F), width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF557F9F), width: 2.0),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Inserisci un titolo';
            }
            return null;
          },
          onChanged: (value) =>
              recipeManager.setTitle(value), // Update recipe title
        ),
      ],
    );
  }

  Widget buildImageUploadContainer() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        margin: EdgeInsets.only(top: 15),
        height: 125,
        decoration: BoxDecoration(
          color: Color(0xFF557F9F).withOpacity(0.2),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Color(0xFF557F9F),
          ),
        ),
        child: Center(
          child: _images.isEmpty
              ? Icon(Icons.add_a_photo)
              : Image.file(
                  File(_images.first),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  Widget buildRatingAndPortions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Voto',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Color(0xFF557F9F), // Specify the desired color
                    ),
              ),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 26, // Set the size of the stars
                itemPadding: EdgeInsets.symmetric(
                    horizontal:
                        2), // Decrease the itemPadding value to make the stars closer
                itemBuilder: (context, _) => Icon(Icons.star,
                    color: Color(0xFF557F9F),
                    size: 10), // Set the size of the stars
                onRatingUpdate: (rating) {
                  setState(() {
                    this._rating = rating;
                  });
                  recipeManager
                      .setRating(rating.toInt()); // Update recipe rating
                },
              ),
            ],
          ),
        ),
        SizedBox(width: 78),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Porzioni',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Color(0xFF557F9F), // Specify the desired color
                        ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: '2', // Set the default value to 2
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF557F9F), width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF557F9F), width: 2.0),
                        ),
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
                        recipeManager.setPortions(
                            int.parse(value)); // Update recipe portions
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildIngredients() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredienti:',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Color(0xFF557F9F), // Specify the desired color
              ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 90,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Quantità',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF557F9F), width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF557F9F), width: 2.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 4), // Decrease the vertical padding
                ),
              ),
            ),
            SizedBox(width: 8),
            SizedBox(
              width: 70,
              child: DropdownButtonFormField(
                value: euMeasures[0], // Set the initial value to 'g'
                items: euMeasures.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF557F9F), width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF557F9F), width: 2.0),
                  ),
                ),
                isExpanded: false, // Set isExpanded to false
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Ingrediente',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF557F9F), width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF557F9F), width: 2.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 20), // Decrease the vertical padding
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                Ingredient ingredient =
                    Ingredient(name: '', quantity: 0, unit: 'g');
                recipeManager.addIngredient(ingredient); // Add new ingredient
              },
              child: Text('+ Ingrediente'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
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
          'Procedimento:',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Color(0xFF557F9F), // Specify the desired color
              ),
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Descrivi i passaggi della ricetta',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF557F9F), width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF557F9F), width: 2.0),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
              margin: EdgeInsets.only(left: 10),
              height: 167,
              width: 125, // Set the desired width
              decoration: BoxDecoration(
                color: Color(0xFF557F9F).withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                color: Color(0xFF557F9F),
                ),
              ),
              child: Center(
                child: _images.isEmpty
                  ? Icon(Icons.add_a_photo)
                  : Image.file(
                    File(_images.first),
                    fit: BoxFit.cover,
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
              recipeManager.addStep(RecipeStep(description: ''));
            });
          },
          child: Text('Aggiungi step'),
        ),
      ],
    );
  }

  Widget buildTotalTime() {
    return Row(
      children: [
        Text('Tempo totale:',
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tag:',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Color(0xFF557F9F), // Specifica il colore desiderato
                )),
        Wrap(
          spacing: 8.0,
          children: List<Widget>.generate(
            Tag.values.length,
            (int index) {
              final tag = Tag.values[index];
              return Container(
                margin: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF557F9F), // Set border color
                    width: 1.0, // Set border width
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Set border radius
                ), // Aggiungi margine per creare un bordo attorno al pulsante
                child: ChoiceChip(
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
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        _selectedTags.add(tag);
                      } else {
                        _selectedTags.remove(tag);
                      }
                      recipeManager.setTag(tag); // Aggiorna i tag della ricetta
                    });
                  },
                  backgroundColor: _selectedTags.contains(tag)
                      ? Color(
                          0xFF557F9F) // Imposta il colore di sfondo su blu se selezionato
                      : Colors
                          .white, // Imposta il colore di sfondo su bianco se non selezionato
                  selectedColor:
                      Color(0xFF557F9F), // Imposta il colore selezionato su blu
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}


/*
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
                  onChanged: (value) =>
                      recipeManager.setTitle(value), // Update recipe title
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
                        recipeManager
                            .setRating(rating.toInt()); // Update recipe rating
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
                        recipeManager
                            .setPortions(value!); // Update recipe portions
                      },
                    ),
                  ],
                ),

                // Ingredienti
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    final section = Section(title: '');
                    final ingredient =
                        Ingredient(name: '', quantity: 0, unit: 'g');
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
                        Text(
                            '${ingredient.quantity} ${ingredient.unit} ${ingredient.name}'),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              widget.section.ingredients.removeAt(index2);
                              recipeManager.removeIngredient(widget.section,
                                  ingredient); // Update recipe ingredients
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
                    recipeManager.addStep(
                        RecipeStep(description: '')); // Update recipe steps
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
                          recipeManager.setDuration(Duration(
                              hours: value!)); // Update recipe duration
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
                          recipeManager.setDuration(Duration(
                              minutes: value!)); // Update recipe duration
                        });
                      },
                    ),
                  ],
                ),

// Tag
                SizedBox(height: 16.0),
                Wrap(
                  spacing: 8.0,
                  children: _selectedTags
                      .map((tag) => Chip(
                            label: Text(tag.name),
                            onDeleted: () {
                              setState(() {
                                _selectedTags.remove(tag);
                                recipeManager.setTags(
                                    _selectedTags); // Update recipe tags
                              });
                            },
                          ))
                      .toList(),
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
                                  recipeManager.setTags(
                                      _selectedTags); // Update recipe tags
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
                      final recipe = recipeManager
                          .recipe; // Get the updated recipe from RecipeManager
                      recipe.sections =
                          _sections; // Update recipe sections with the current state
                      recipe.steps =
                          _steps; // Update recipe steps with the current state

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

enum StepAction { setTimer, removeTimer, deleteStep } */
