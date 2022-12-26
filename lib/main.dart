import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(
    MaterialApp(
      home: MyApp()
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var userImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("instagram"),
        actions: [
          IconButton(onPressed: () async {
            var picker = ImagePicker();
            var image = await picker.pickImage(source: ImageSource.gallery);
            if(image != null) {
              setState(() {
                userImage = File(image.path);
              });
            }
          }, icon: Icon(Icons.add_box_outlined))
        ],
      ),
      body: Board(userImage : userImage)
    );
  }
}

class Board extends StatefulWidget {
  const Board({Key? key, required this.userImage}) : super(key: key);
  final userImage;

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {

  @override
  Widget build(BuildContext context) {
    if(widget.userImage != null) {
      return ListView(
        children: [
          Column(
            children: [
              Image.file(widget.userImage),
              Text("담비"),
              Text("좋아요 100")
            ],
          )
        ],
      );
    } else {
      return Text("이미지가 없습니다.");
    }
  }
}
