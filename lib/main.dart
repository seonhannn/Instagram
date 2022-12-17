import 'package:flutter/material.dart';
import 'style.dart';

void main() {
  runApp(
    MaterialApp(
      theme: theme,
      home: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instagram"),
        actions: [
          Icon(Icons.add),
          SizedBox(width: 20),
          Icon(Icons.favorite_border),
          SizedBox(width: 20),
          Icon(Icons.send)
        ],
      ),
      body: Container(
        
      )
    );
  }
}

