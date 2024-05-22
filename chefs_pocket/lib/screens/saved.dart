import 'dart:io';

import 'package:chefs_pocket/components/saved/directory_card.dart';
import 'package:chefs_pocket/models/directory.dart';
import 'package:chefs_pocket/screens/directory_page.dart';
import 'package:chefs_pocket/models/recipe.dart';
import 'package:chefs_pocket/components/saved/recipe_saved_element.dart';
import 'package:chefs_pocket/screens/recipe_page.dart';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '/config.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SavedScreen extends StatefulWidget {
  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  FocusNode myFocusNode = FocusNode();
  bool hasFocus = false;
  bool modModify = false;

  final List<Tag> _selectedFilterTags = [];
  double _rating = 0.0;
  Duration _time = Duration(minutes: 20);

  final MAX_COOKING_TIME = Duration(minutes: 5000);

  late Future<PickedFile?> pickedFile = Future.value(null);

  Directory allSavedRecipesDir = savedRecipesDirectory;
  List<Directory> directories = mockDirectories;

  List<Recipe> currentRecipes = [];
  bool filtersApplied = false;
  List<dynamic> activeFilters = [];

  final TextEditingController _searchController = TextEditingController();

  String title = '';
  File? image;

  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {}
    });
  }

  void applyFilters(List<Recipe> recipes, List<Tag> selectedTags,
      double? rating, Duration time) {
    List<Recipe> filteredRecipes = recipes.where((recipe) {
      // Filtra per tag
      if (!selectedTags.every((tag) => recipe.tags.contains(tag))) {
        return false;
      }

      // Filtra per voto
      if (rating != null && recipe.rating < rating) {
        return false;
      }

      // Filtra per tempo
      if (recipe.totalTime > time) {
        return false;
      }

      return true;
    }).toList();

    if (filteredRecipes.isEmpty) {
      // Mostra un messaggio di errore se non ci sono ricette che soddisfano i filtri
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nessuna ricetta trovata'),
        ),
      );
    } else {
      setState(() {
        currentRecipes = filteredRecipes;
        activeFilters = [selectedTags, rating, time];
        filtersApplied = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      setState(() {
        hasFocus = myFocusNode.hasFocus;
      });
    });
    // Aggiungi un listener al controller
    _searchController.addListener(() {
      setState(() {
        // Filtra l'elenco di ricette ogni volta che il testo cambia
        allSavedRecipes = allSavedRecipesDir.recipes
            .where((recipe) => recipe.title
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ricette Salvate",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF557F9F)),
          onPressed: () {
            // implementare la logica per aprire il drawer
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background/saved_background.png"),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height *
                      0.1), // Sposta il widget verso il basso del 10% dell'altezza dello schermo
              child: buildContent(),
            ),
          ),
          if (_searchController.text.isNotEmpty)
            Positioned.fill(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
            child: Center(child: buildSearchBar()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
              setState(() {
                modModify = !modModify;
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            child:
                Icon(modModify ? Icons.check : Icons.edit, color: Colors.white),
      ),
    );
  }

  Widget buildSearchBar() {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: const Color(0xFF557F9F), // Set the background color to blue
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    color: const Color(0xFFFFFDF4),
                    fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                    fontWeight:
                        Theme.of(context).textTheme.bodyLarge?.fontWeight,
                  ),
                  focusNode: myFocusNode,
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: hasFocus ? '' : "Cerca una ricetta",
                    hintStyle: TextStyle(
                      fontFamily: "Montserrat",
                      color: const Color(0xFFFFFDF4).withOpacity(0.5),
                      fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                      fontWeight:
                          Theme.of(context).textTheme.bodyLarge?.fontWeight,
                    ),
                    prefixIcon:
                        const Icon(Icons.search, color: Color(0xFFFFFDF4)),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Visibility(
                visible: _searchController.text.isNotEmpty,
                child: IconButton(
                  icon: const Icon(Icons.clear, color: Color(0xFFFFFDF4)),
                  onPressed: () {
                    _searchController.clear();
                  },
                ),
              ),
              const SizedBox(width: 3),
              IconButton(
                icon: const Icon(Icons.filter_list, color: Color(0xFFFFFDF4)),
                onPressed: () {
                  setState(() {
                    // Implementare la logica per mostrare i filtri
                    _searchController.clear();
                    showFilterOptions(context);
                  });
                },
              ),
            ],
          ),
        ),
        if (_searchController.text.isNotEmpty)
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDF4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              shrinkWrap:
                  true, // Questo permette al ListView di funzionare all'interno di un Column
              itemCount: allSavedRecipes.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(allSavedRecipes[index].title),
                      onTap: () {
                        // Implementa la logica per aprire la pagina della ricetta
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RecipePage(recipe: allSavedRecipes[index]),
                          ),
                        );
                      },
                    ),
                    Divider(
                        color: const Color(0xFF557F9F).withOpacity(
                            0.5)), // Aggiungi una linea blu tra ogni ListTile
                  ],
                );
              },
            ),
          ),
      ],
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
                  : const Color(0xFF557F9F),
            ),
          ),
          selected: _selectedFilterTags.contains(tag),
          selectedColor: const Color(0xFF557F9F),
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
            side: const BorderSide(
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
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) =>
          const Icon(Icons.star, color: Color(0xFF557F9F)),
      onRatingUpdate: (new_rating) {
        setState(() {
          // Implementa la logica per il filtro della valutazione in stelle
          _rating = new_rating;
        });
      },
    );
  }

  Widget buildTimeFilter(StateSetter setState) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(valueIndicatorColor: Colors.white),
      child: Slider(
        value: _time.inMinutes.toDouble(),
        min: 0,
        max: 100,
        divisions: 5,
        label: '< ${_time.inHours}h ${_time.inMinutes.remainder(60)}m',
        onChanged: (value) {
          setState(() {
            _time = Duration(minutes: value.toInt());
          });
          // Implementa la logica per il filtro del tempo
        },
      ),
    );
  }

  void showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFFFFDF4),
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
                            color: const Color(0xFF557F9F),
                          ),
                    ),
                  ),
                  buildTagFilter(setState),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Voto',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF557F9F),
                          ),
                    ),
                  ),
                  buildRatingFilter(setState),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Durata',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF557F9F),
                          ),
                    ),
                  ),
                  buildTimeFilter(setState),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Annulla',
                          style: TextStyle(
                            color: Color(0xFF557F9F),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Implementa la logica per applicare i filtri
                          applyFilters(allSavedRecipes, _selectedFilterTags,
                              _rating, _time);

                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF557F9F),
                          foregroundColor: const Color(0xFFFFFDF4),
                        ),
                        child: const Text('Applica',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
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
                      height: MediaQuery.of(context).size.height / 5,
                      decoration: BoxDecoration(
                        color: const Color(0xFF557F9F).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DottedBorder(
                        padding: const EdgeInsets.all(0),
                        radius: const Radius.circular(5),
                        color: const Color(0xFF557F9F),
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
                              : const Icon(Icons.add_photo_alternate_outlined,
                                  color: Color(0xFF557F9F), size: 30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 30),
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
                  child: const Text('Annulla'),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF557F9F),
                      foregroundColor: const Color(0xFFFFFDF4),
                    ),
                    child: const Text('Salva')),
              ],
            );
          },
        );
      },
      child: Container(
        child: DottedBorder(
          padding: const EdgeInsets.all(0),
          radius: const Radius.circular(10),
          color: const Color(0xFF557F9F),
          dashPattern: [5, 5],
          borderType: BorderType.RRect,
          strokeWidth: 2,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF557F9F).withOpacity(0.2),
              borderRadius: BorderRadius.circular(5),
              border:
                  Border.all(color: const Color(0xFF557F9F).withOpacity(0.2)),
            ),
            child: const Center(
              child: Icon(Icons.add, color: Color(0xFF557F9F), size: 30),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFilteredRecipes() {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.start,
          direction: Axis.horizontal,
          spacing: 8.0,
          runSpacing: 10.0,
          children: [
            if (activeFilters[0] is List<Tag> &&
                (activeFilters[0] as List<Tag>).isNotEmpty)
              ...activeFilters[0].map((tag) {
                return Chip(
                  backgroundColor: const Color(0xFFFFFDF4),
                  labelStyle: const TextStyle(color: Color(0xFF557F9F)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: Color(0xFF557F9F),
                    ),
                  ),
                  label: Text(tag.toString().split('.').last),
                  deleteIcon: Icon(Icons.close, color: Color(0xFF557F9F)),
                  onDeleted: () {
                    setState(() {
                      activeFilters[0].remove(tag);
                      applyFilters(allSavedRecipes, activeFilters[0],
                          activeFilters[1], activeFilters[2]);
                    });
                  },
                );
              }),
            if (activeFilters[1] != null)
              Chip(
                backgroundColor: const Color(0xFFFFFDF4),
                labelStyle: const TextStyle(color: Color(0xFF557F9F)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: Color(0xFF557F9F),
                  ),
                ),
                label: Wrap(
                  children: [
                    Icon(Icons.star, color: Color(0xFF557F9F)),
                    SizedBox(width: 3),
                    Text(activeFilters[1].toString()),
                  ],
                ),
                deleteIcon: Icon(Icons.close, color: Color(0xFF557F9F)),
                onDeleted: () {
                  setState(() {
                    activeFilters[1] =
                        null; // Se toglie il filtro alle stelle allora mostro le ricette con qualunque valutazione
                    applyFilters(allSavedRecipes, activeFilters[0],
                        activeFilters[1], activeFilters[2]);
                  });
                },
              ),
            if (activeFilters[2] != MAX_COOKING_TIME)
              Chip(
                backgroundColor: const Color(0xFFFFFDF4),
                labelStyle: const TextStyle(color: Color(0xFF557F9F)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: Color(0xFF557F9F),
                  ),
                ),
                label: Wrap(
                  children: [
                    Icon(Icons.timer, color: Color(0xFF557F9F)),
                    SizedBox(width: 3),
                    Text(
                        '${activeFilters[2].inHours}h ${activeFilters[2].inMinutes.remainder(60)}m'),
                  ],
                ),
                deleteIcon: Icon(Icons.close, color: Color(0xFF557F9F)),
                onDeleted: () {
                  setState(() {
                    activeFilters[2] =
                        MAX_COOKING_TIME; // Se toglie il filtro al tempo allora imposto il tempo massimo
                    applyFilters(allSavedRecipes, activeFilters[0],
                        activeFilters[1], activeFilters[2]);
                  });
                },
              ),
          ],
        ),
        TextButton(
          child: Text('Cancella filtri'),
          onPressed: () {
            setState(() {
              activeFilters.clear();
              filtersApplied = false;
              currentRecipes = allSavedRecipes;
            });
          },
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: currentRecipes.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RecipePage(recipe: currentRecipes[index]),
                    ),
                  );
                });
              },
              child: RecipeSavedElement(recipe: currentRecipes[index], modModify: modModify),
            );
          },
        ),
      ],
    );
  }

  Widget buildDirectories() {
    return GridView.builder(
        shrinkWrap: true,
        itemCount:  modModify ? (directories.length + 2) : (directories.length + 1),
        itemBuilder: (BuildContext context, int index) {
          if (index == directories.length + 1 && modModify) {
            return buildAddDirectory();
          } else if (index == directories.length) {
            // Render AllSavedRecipesDir
            return GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DirectoryPage(directory: allSavedRecipesDir)),
                  );
                });
              },
              child: DirectoryCard(
                  directory: allSavedRecipesDir, modModify: modModify),
            );
          } else {
            return GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DirectoryPage(directory: directories[index]),
                    ),
                  );
                });
              },
              child: DirectoryCard(
                  directory: directories[index], modModify: modModify),
            );
          }
        },
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ));
  }

  Widget buildContent() {
    if (filtersApplied) {
      return buildFilteredRecipes();
    } else {
      return buildDirectories();
    }
  }
}
