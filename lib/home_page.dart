import 'dart:io';

import 'package:camera/pop_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? image;

  List<String> listImagePath = [];

  @override
  void initState() {
    super.initState();
    Directory dir =
        Directory.fromUri(Uri.parse('/data/user/0/com.example.camera/'));
    _fetchFiles(dir);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera app"),
      ),
      body: GridView.builder(
        itemCount: listImagePath.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                        builder: (ctx) => PopScreen(
                          image: listImagePath[index],)));
                },
                child: Hero(
                    tag: listImagePath[index],
                    child: Image.file(File(listImagePath[index].toString())))),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera),
        onPressed: () async {
          var result =
              await ImagePicker().pickImage(source: ImageSource.camera);
          if (result == null) {
            print("image null");
            return;
          }
          image = File(result.path);
          // print(result.path);
          await image!.copy(
              '/data/user/0/com.example.camera/Image${DateTime.now()}.jpg');
          Directory dir =
              Directory.fromUri(Uri.parse('/data/user/0/com.example.camera/'));
          _fetchFiles(dir);
          setState(() {});
        },
      ),
    );
  }

  _fetchFiles(Directory dir) async {
    listImagePath.clear();
    var value = await dir.list().toList();
    // print(value);
    for (int i = 0; i < value.length; i++) {
      if (value[i]
              .path
              .substring((value[i].path.length - 4), (value[i].path.length)) ==
          ".jpg") {
        listImagePath.add(value[i].path);
      }
    }
    setState(() {});
  }
}
