import 'package:flutter/material.dart';
import 'style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  var data;

  getData() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    data = jsonDecode(result.body);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

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
      body: [Board(data : data), Text("null")][tab],
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
  const Board({Key? key, this.data}) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    print(data);
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (c, i) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(data[i]['image']),
            Row(
              children: [
                Text("좋아요"),
                Text((data[i]['likes']).toString())
              ],
            ),
            Text(data[i]['user']),
            Text(data[i]['content'])
          ],
        );
      },
    );
  }
}