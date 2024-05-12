import 'package:flutter/material.dart';
//probabilmente da fare stateful perche cambia le ricette mostrate se premo su una delle 4 
class ClipOvalWithText extends StatelessWidget {
  final String text;
  final String image;

  ClipOvalWithText({required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle your onTap action here
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
              child: Image.network(
            image,
            width: 80,
            height: 80,
            fit: BoxFit.contain,
          )),
          Text(text, style: Theme.of(context).textTheme.titleSmall)
        ],
      ),
    );
  }
}
