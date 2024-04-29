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
                height: 24,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black.withOpacity(0.6)
                      : Colors.white.withOpacity(0.6),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: NetworkImage(widget.recipe.imageUrl), height: 20, width: 20),
                    Text(
                      widget.recipe.title,
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(width: 7), // Spazio tra il titolo e la valutazione
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
            ),
          ],
        ),
      ),
    );
  }
}
