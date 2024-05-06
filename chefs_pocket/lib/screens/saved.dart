import 'package:flutter/material.dart';
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
            //buildSaved()
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

  Widget buildSaved() {
    return Column(
      children: [
        // Implement the logic to show the saved recipes
      ],
    );
  }
}
