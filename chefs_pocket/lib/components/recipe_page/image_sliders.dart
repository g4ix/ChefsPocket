import 'package:flutter/material.dart';

class ImageSliders extends StatelessWidget {
  final List<String> imageUrls;

  ImageSliders({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: (imageUrls.isNotEmpty)?  PageView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child:Image.network(
              imageUrls[index],
              fit: BoxFit.cover,
            ) 
          );
        },
      ) : (Image.network('../assets/background/family.jpg', fit: BoxFit.cover))
    );
  }
}