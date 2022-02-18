import 'dart:io';


import 'package:flutter/material.dart';

class PopScreen extends StatelessWidget {
  const PopScreen({ Key? key ,this.image}) : super(key: key);
final dynamic image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
     body:Center(
       child: Hero(
         tag: image
         ,child: Image.file(File(image.toString()))),
     ),
      
    );
  }
}