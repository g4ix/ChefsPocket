import 'dart:io';

import 'package:chefs_pocket/components/directory_card.dart';
import 'package:chefs_pocket/models/directory.dart';
import 'package:chefs_pocket/screens/directory_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';

import '/config.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SavedScreen extends StatefulWidget {
  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  FocusNode myFocusNode = FocusNode();
  bool hasFocus = false;
  double _currentSliderValue = 20.0;
  final List<Tag> _selectedFilterTags = [];
  final ImagePicker _picker = ImagePicker();
  late Future<PickedFile?> pickedFile = Future.value(null);

  List<Directory> directories = mockDirectories;
  String title = '';
  File? image;

  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('Nessuna immagine selezionata.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      setState(() {
        hasFocus = myFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Salvati",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF557F9F)),
          onPressed: () {
            // implementare la logica per aprire il drawer
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            buildSearchBar(),
            SizedBox(height: 20),
            buildSaved(),
          ],
        ),
      ),
    );
  }

  Widget buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFF557F9F), // Set the background color to blue
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(
                fontFamily: "Montserrat",
                color: Color(0xFFFFFDF4),
                fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                fontWeight: Theme.of(context).textTheme.bodyLarge?.fontWeight,
              ),
              focusNode: myFocusNode,
              decoration: InputDecoration(
                hintText: hasFocus ? '' : "Ingredienti, ricette...",
                hintStyle: TextStyle(
                  fontFamily: "Montserrat",
                  color: Color(0xFFFFFDF4),
                  fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                  fontWeight: Theme.of(context).textTheme.bodyLarge?.fontWeight,
                ),
                prefixIcon: Icon(Icons.search,
                    color: Color(0xFFFFFDF4)), // Set the icon color to yellow
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.filter_list,
                color: Color(0xFFFFFDF4)), // Set the icon color to yellow
            onPressed: () {
              setState(() {
                // Implement the logic to open the filter drawer
                showFilterOptions(context);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildTagFilter(StateSetter setState) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 10.0,
      children: Tag.values.map((tag) {
        return FilterChip(
          label: Text(
            tag.toString().replaceAll('Tag.', ''),
            style: TextStyle(
              color: _selectedFilterTags.contains(tag)
                  ? Colors.white
                  : Color(0xFF557F9F),
            ),
          ),
          selected: _selectedFilterTags.contains(tag),
          selectedColor: Color(0xFF557F9F),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _selectedFilterTags.add(tag);
              } else {
                _selectedFilterTags.remove(tag);
              }
            });
          },
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Color(0xFF557F9F),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
        );
      }).toList(),
    );
  }

  Widget buildRatingFilter(StateSetter setState) {
    return RatingBar.builder(
      initialRating: 3,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(Icons.star, color: Color(0xFF557F9F)),
      onRatingUpdate: (rating) {
        setState(() {
          // Implementa la logica per il filtro della valutazione in stelle
        });
      },
    );
  }

  Widget buildTimeFilter(StateSetter setState) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(valueIndicatorColor: Colors.white),
      child: Slider(
        value: _currentSliderValue,
        min: 0,
        max: 100,
        divisions: 5,
        label: '${_currentSliderValue.round()} min',
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value;
          });
          // Implementa la logica per il filtro del tempo
        },
      ),
    );
  }

  void showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFFFFFDF4),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Filtri',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Tag',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF557F9F),
                          ),
                    ),
                  ),
                  buildTagFilter(setState),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Voto',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF557F9F),
                          ),
                    ),
                  ),
                  buildRatingFilter(setState),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Durata',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF557F9F),
                          ),
                    ),
                  ),
                  buildTimeFilter(setState),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildAddDirectory() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 170,
                      decoration: BoxDecoration(
                        color: Color(0xFF557F9F).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DottedBorder(
                        padding: EdgeInsets.all(0),
                        radius: Radius.circular(5),
                        color: Color(0xFF557F9F),
                        dashPattern: [5, 5],
                        borderType: BorderType.RRect,
                        strokeWidth: 2,
                        child: Center(
                          child: image != null
                              ? Image.file(
                                  image!,
                                  height:
                                      MediaQuery.of(context).size.height / 5,
                                )
                              : Icon(
                                  Icons.add_photo_alternate_outlined,
                                  color: Color(0xFF557F9F),
                                  size: 30
                              ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    onChanged: (value) {
                      title = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Inserisci il titolo',
                      hintStyle: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Annulla'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (title.isNotEmpty && image != null) {
                      // Creare un nuovo oggetto Directory
                      Directory newDirectory =
                          Directory(name: title, imageUrl: image!.path);

                      // Aggiungere la nuova directory a una lista di directory
                      setState(() {
                        directories.add(newDirectory);
                      });
                      // Chiudi il dialog
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Salva'),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        child: DottedBorder(
          padding: EdgeInsets.all(0),
          radius: Radius.circular(10),
          color: Color(0xFF557F9F),
          dashPattern: [5, 5],
          borderType: BorderType.RRect,
          strokeWidth: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF557F9F).withOpacity(0.2),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Color(0xFF557F9F).withOpacity(0.2)),
            ),
            child: Center(
              child: Icon(Icons.add, color: Color(0xFF557F9F), size: 30),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSaved() {
  return GridView.builder(
      shrinkWrap: true,
      itemCount: directories.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == directories.length) {
          return buildAddDirectory();
        } else {
          return GestureDetector(
            onTap: () {
              setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => DirectoryPage(directory: directories[index]),
                ),
              );
              });
            },
            child: DirectoryCard(directory: directories[index]),
          );
        }
      },
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ));
}
}
