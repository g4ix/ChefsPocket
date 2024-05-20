import 'package:chefs_pocket/models/directory.dart';
import 'package:chefs_pocket/screens/saved.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chefs_pocket/components/saved/recipe_saved_element.dart';

class DirectoryPage extends StatefulWidget {
  final Directory directory;

  DirectoryPage({required this.directory});

  @override
  _DirectoryPageState createState() => _DirectoryPageState();
}

class _DirectoryPageState extends State<DirectoryPage> {
  bool modModify = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Color(0xFF557F9F),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () {
                setState(() {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => SavedScreen()),
                  );
                });
              },
            ),
            actions: [
              IconButton(
                icon: Icon(
                  modModify ? Icons.check : Icons.edit,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    modModify = !modModify;
                  });
                },
              ),
            ],
            expandedHeight: 250.0,
            pinned: true,
            title: Text(
              widget.directory.name,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.directory.imageUrl),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Open recipe page
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                    child: RecipeSavedElement(
                      recipe: widget.directory.recipes[index],
                      modModify: modModify,
                    ),
                  ),
                );
              },
              childCount: widget.directory.recipes.length,
            ),
          ),
        ],
      ),
    );
  }
}
