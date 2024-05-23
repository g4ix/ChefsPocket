import 'package:flutter/material.dart';

//probabilmente da fare stateful perche cambia le ricette mostrate se premo su una delle 4
class ClipOvalWithText extends StatelessWidget {
  final String text;
  final AssetImage image;
  bool isSelected;
  final VoidCallback onPressed;

  ClipOvalWithText(
      {required this.text,
      required this.image,
      required this.onPressed,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.tertiary
              : Colors.transparent, // Change color if highlighted
          boxShadow: isSelected
              ? [
                  BoxShadow(
                      color: Theme.of(context).colorScheme.secondary,
                      blurRadius: 5)
                ]
              : null,

          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipOval(
              child: Image.asset(
                image.assetName ,
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
            ),
            Text(text, style: Theme.of(context).textTheme.titleSmall)
          ],
        ),
      ),
    );
  }
}
