import 'package:chefs_pocket/config.dart';
import 'package:chefs_pocket/screens/recipe_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/recipe.dart';

class RecipeCard extends StatefulWidget {
  final Recipe recipe;
  final bool modModify;
  final bool modAdd;
  final Function(Recipe)? onRemoveRecipe;
  final Function()? addRecipe;

  const RecipeCard(
      {required this.recipe,
      required this.modModify,
      this.onRemoveRecipe,
      this.modAdd = false,
      this.addRecipe});

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        if (widget.modAdd) {
          widget.addRecipe!();
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecipePage(recipe: widget.recipe)),
          );
        }
      },
      child: Container(
        width: width * 0.6, // 80% of screen width
        height: height * 0.5,
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
                    width: width * 0.6, // 80% of screen width
                    height: height * 0.15,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black.withOpacity(0.6)
                          : Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: height * 0.5, // 20% of screen height
                        width: width * 0.6, // 80% of screen width
                        margin: const EdgeInsets.all(
                            8.0), // Crea un bordo di 8 pixel
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black.withOpacity(0.6)
                              : Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(5.0),
                          image: DecorationImage(
                            image: AssetImage(widget.recipe.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2),
                  Container(
                    width: width * 0.59, // 80% of screen width
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.recipe.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.fontFamily,
                              fontSize: height * 0.02,
                            ),
                          ),
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
              if (widget
                  .modModify) //bottone per eliminare la ricetta dalla lista
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    iconSize: height * 0.02,
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: () {
                      if (widget.onRemoveRecipe != null)
                        widget.onRemoveRecipe!(widget.recipe);
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
