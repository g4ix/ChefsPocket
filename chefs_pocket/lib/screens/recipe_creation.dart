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

  Recipe recipe = Recipe();

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
          style: Theme.of(context).textTheme.titleMedium,
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
            SizedBox(height: 5),
            buildIngredients(),
            SizedBox(height: 5),
            buildProcedure(),
            SizedBox(height: 5),
            buildTotalTime(),
            SizedBox(height: 5),
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
        TextFormField(
        
          decoration:  InputDecoration(
            focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
            borderRadius: BorderRadius.circular(10.0), // make this the same or smaller than the borderRadius for enabledBorder and focusedBorder
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF557F9F), width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),            hintText: 'Inserisci il titolo',
            
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Inserisci un titolo';
            }
            return null;
          },
          onChanged: (value) =>
              recipe.setTitle(value), // Update recipe title
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
              border: Border.all(
                color: Color(0xFF557F9F).withOpacity(0.2)
              ),
            ),
            child: Center(
              child: _images.isEmpty? Icon(Icons.add_a_photo, color: Color(0xFF557F9F)): Image.file(
                      File(_images.first),
                      fit: BoxFit.cover,
                    ),
            ),
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
              Row(
                children: [
                  SizedBox(height: 5),
                  Text(
                    'Voto',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Color(0xFF557F9F), // Specify the desired color
                        ),
                  ),
                  SizedBox(width: 5),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20, // Set the size of the stars
                    itemPadding: EdgeInsets.symmetric(horizontal:0), // Decrease the itemPadding value to make the stars closer
                    itemBuilder: (context, _) => Icon(Icons.star,
                        color: Color(0xFF557F9F), size: 10), // Set the size of the stars
                    onRatingUpdate: (rating) {
                      setState(() {
                        this._rating = rating;
                      });
                      recipe.setRating(rating.toInt()); // Update recipe rating
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 30),
      
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 60,
              child: TextFormField(
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  
                   focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
                      borderRadius: BorderRadius.circular(10.0), // make this the same or smaller than the borderRadius for enabledBorder and focusedBorder
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),),
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey, fontSize: 14),
                  hintText: '500',
                 
                  contentPadding: EdgeInsets.symmetric(vertical: 2), // Decrease the vertical padding
                ),
              ),
            ),
            SizedBox(width: 8),
            SizedBox(
              width: 70,
              child: DropdownButtonFormField(
                borderRadius: BorderRadius.circular(10),
                value: euMeasures[0], // Set the initial value to 'g'
                items: euMeasures.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                  );
                }).toList(),
                onChanged: (_) {},
                decoration: InputDecoration(
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
                      borderRadius: BorderRadius.circular(10.0), // make this the same or smaller than the borderRadius for enabledBorder and focusedBorder
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),),
                ),
                isExpanded: false, // Set isExpanded to false
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  hintText: 'Ingrediente',
                focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
                      borderRadius: BorderRadius.circular(10.0), // make this the same or smaller than the borderRadius for enabledBorder and focusedBorder
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 10), // Decrease the vertical padding
                ),
              ),
            ),
          ],
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
                          color: Color(0xFF557F9F), // Specify the desired color
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
                              borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
                              borderRadius: BorderRadius.circular(10.0), // make this the same or smaller than the borderRadius for enabledBorder and focusedBorder
                            ),
                        enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF557F9F), width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                        focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF557F9F), width: 2.0),
                              borderRadius: BorderRadius.circular(10.0)),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 8, horizontal:10), // Adjust the vertical and horizontal padding
                        alignLabelWithHint:  true, // Align the label with the input field
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

            ElevatedButton(
              onPressed: () {
                Ingredient ingredient =
                    Ingredient(name: '', quantity: 0, unit: 'g');
                recipeManager.addIngredient(ingredient); // Add new ingredient
              },
              child: Text('+ Ingrediente', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),),
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
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
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
              width: 125, // Set the desired width
              decoration: BoxDecoration(
                color: Color(0xFF557F9F).withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
                border: Border.all( color: Color(0xFF557F9F).withAlpha(20),
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
                  child: _images.isEmpty? Icon(Icons.add_a_photo): Image.file(
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
              recipe.addStep(RecipeStep(description: ''));
            });
          },
          style: ElevatedButton.styleFrom(
               foregroundColor: Colors.white,
                backgroundColor: Color(0xFF557F9F),
                disabledForegroundColor: Color(0xFFF557F9F),
                disabledBackgroundColor: Colors.white,
            ),
          
          child: Text('Aggiungi step', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
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


