import 'package:chefs_pocket/models/recipe.dart';
import 'package:flutter/material.dart';

class RecipeViewer extends StatefulWidget {
  late Recipe recipe;
  @override
  _RecipeViewerState createState() => _RecipeViewerState();
}

class _RecipeViewerState extends State<RecipeViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

         leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit_calendar_rounded), onPressed: () {  },
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.bookmark_add_rounded)),
          IconButton(onPressed: (){}, icon: Icon(Icons.edit))
        ],
      ),
      body: Center(
        child: Text('This is the Recipe Viewer'),
      ),
    );
  }
}
