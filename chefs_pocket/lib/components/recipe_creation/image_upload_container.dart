import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ImageUploadContainer extends StatelessWidget{

  final Function _pickImage;
  final List<String> _images;

  ImageUploadContainer(this._pickImage, this._images);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pickImage();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DottedBorder(
          padding: EdgeInsets.all(0),
          radius: Radius.circular(10),
          color: Color(0xFF557F9F),
          dashPattern: [5, 5],
          borderType: BorderType.RRect,
          strokeWidth: 2,
          child: Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: Color(0xFF557F9F).withOpacity(0.2),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Color(0xFF557F9F).withOpacity(0.2)),
            ),
            child: Center(
              child: _images.isEmpty
                  ? Icon(Icons.add_a_photo, color: Color(0xFF557F9F))
                  : Image.file(
                      File(_images.first),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
      ),
    );
  }

}