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
    // Secondo me serve dell'ombra o comunque qualcosa che faccia da divisorio perchè 
    // altrimenti non si pervepisce bene il bordo della card
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0.1,
            blurRadius: 5,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child:
    Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 130,
              width: 240,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black.withOpacity(0.6)
                    : Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 122,
                  width: double.infinity,
                  margin: const EdgeInsets.all(8.0), // Crea un bordo di 8 pixel
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black.withOpacity(0.6)
                        : Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                      image: NetworkImage(widget.recipe.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 2),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Column(
                children: [
                  Text(widget.recipe.title,
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                      style: Theme.of(context).textTheme.bodyLarge),
                  SizedBox(height: 3),
                  RatingBarIndicator(
                    rating: widget.recipe.rating.toDouble(),
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Color(0xFF557F9F),
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                ],
              ),
            ),
          ],
        ),
    ),
    );
  }
}
