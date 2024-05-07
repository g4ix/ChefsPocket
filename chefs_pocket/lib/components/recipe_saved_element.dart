import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/recipe.dart';

class RecipeSavedElement extends StatefulWidget {
  final Recipe recipe;

  const RecipeSavedElement({required this.recipe});

  @override
  State<RecipeSavedElement> createState() {
    return _RecipeSavedElementState();
  }
}

class _RecipeSavedElementState extends State<RecipeSavedElement> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Open the specific recipe page
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Add the desired padding value
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(0xFFFFFDF4),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                    image: NetworkImage(widget.recipe.imageUrl),
                    fit: BoxFit.cover,
                  ), // Add the desired border radius value
                ),
              ),
              const SizedBox(width: 15.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recipe.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBarIndicator(
                          rating: widget.recipe.rating.toDouble(),
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Color(0xFF557F9F),
                          ),
                          itemCount: 5,
                          itemSize: 23,
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(width: 8.0),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.grey[200],
                          ),
                          child: Row(
                          children: [
                            const Icon(Icons.timer, color: Color(0xFF557F9F)),
                            const SizedBox(width: 4.0),
                            Text('${widget.recipe.totalTime.inHours} h ${widget.recipe.totalTime.inMinutes.remainder(60)} m'),
                          ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
