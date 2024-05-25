import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chefs_pocket/screens/directory_page.dart';
import '../../models/directory.dart';

class DirectoryCard extends StatefulWidget {
  final Directory directory;
  final bool modModify;

  final Function(Directory)? onRemoveDirectory;

  const DirectoryCard(
      {required this.directory,
      required this.modModify,
      this.onRemoveDirectory});

  @override
  State<DirectoryCard> createState() {
    return _DirectoryCardState();
  }
}

class _DirectoryCardState extends State<DirectoryCard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

     return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Lo stesso valore del Card
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 15,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.14,
                  width: MediaQuery.of(context).size.width * 0.7,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin:
                        const EdgeInsets.all(8.0), // Crea un bordo di 8 pixel
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black.withOpacity(0.6)
                          : Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                        image: AssetImage(widget.directory.imageUrl ?? 'assets/placeholder.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Column(
                      children: [
                        Text(
                          widget.directory.name,
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.fontFamily,
                            fontSize: height * 0.02,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
            if (widget.modModify && widget.directory.name != "Ricette Salvate")
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  iconSize: height * 0.02,
                  icon: Icon(Icons.close, color: Colors.white),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.primary),
                  ),
                  onPressed: () {
                    if (widget.onRemoveDirectory != null) {
                      widget.onRemoveDirectory!(widget.directory);
                    }
                  },
                ),
              ),
          ],
        ),
      ),
      
    );
  }
}
