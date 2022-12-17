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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;

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
      body: [Text("home"), Text("shop")][tab],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i){
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "search"),
        ],
      )
    );
  }
}

