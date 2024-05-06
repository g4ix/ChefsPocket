import 'package:flutter/material.dart';
import '../models/directory.dart';

class DirectoryCard extends StatefulWidget {
  final Directory directory;

  const DirectoryCard({required this.directory});

  @override
  State<DirectoryCard> createState() {
    return _DirectoryCardState();
  }
}

class _DirectoryCardState extends State<DirectoryCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height:130,
                width: 200,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black.withOpacity(0.6)
                      : Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Image(image: NetworkImage(widget.directory.imageUrl), height: double.infinity, width: double.infinity, fit: BoxFit.cover,),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(left:8.0),
                  child: Column( 
                    children: [     
                      Text(
                        widget.directory.name,
                        maxLines: 1,
                        overflow: TextOverflow.visible,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                
                  ),
                ),
              ),


          ],
        ),
      ),
    );
  }
}
