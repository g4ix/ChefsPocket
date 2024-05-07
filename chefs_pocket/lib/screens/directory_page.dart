import 'package:chefs_pocket/models/directory.dart';
import 'package:chefs_pocket/screens/saved.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chefs_pocket/components/recipe_saved_element.dart';

class DirectoryPage extends StatefulWidget {
  final Directory directory;

  DirectoryPage({required this.directory});

  @override
  _DirectoryPageState createState() => _DirectoryPageState();
}

class _DirectoryPageState extends State<DirectoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.directory.imageUrl),
                      fit: BoxFit.cover ,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        widget.directory.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 225,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      color: Color(0xFFFFFDF4),
                    ),
                    child: ListView.builder(
                      itemCount: widget.directory.recipes.length,
                      itemBuilder: (context, index) {
                        return RecipeSavedElement(
                          recipe: widget.directory.recipes[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
