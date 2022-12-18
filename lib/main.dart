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
      body: [Board(), Text("shop")][tab],
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

class Board extends StatelessWidget {
  const Board({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('./assets/snowman.jpg'),
              Row(
                children: [
                  Text("좋아요"),
                  Text("100")
                ],
              ),
              Text("글쓴이"),
              Text("글 내용")
            ],
        );
      },
    );
  }
}

