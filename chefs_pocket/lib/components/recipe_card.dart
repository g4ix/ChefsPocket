import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/recipe.dart';

class RecipeCard extends StatefulWidget {
  final Recipe recipe;

  const RecipeCard({required this.recipe});

  @override
  State<RecipeCard> createState() {
    return _RecipeCardState();
  }
}

class _RecipeCardState extends State<RecipeCard> {
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
                width: 240,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black.withOpacity(0.6)
                      : Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Image(image: NetworkImage(widget.recipe.imageUrl), height: double.infinity, width: double.infinity, fit: BoxFit.cover,),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(left:8.0),
                  child: Column( 
                    children: [     
                      Text(
                        widget.recipe.title,
                        maxLines: 1,
                        overflow: TextOverflow.visible,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                       // Spazio tra il titolo e la valutazione
                      RatingBarIndicator(
                        rating: widget.recipe.rating.toDouble(),
                        itemBuilder: (context, index) => Icon( Icons.star,
                          color: Color(0xFF557F9F),),
                        itemCount: 5,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
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
