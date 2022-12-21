import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart';

main() {
  runApp(
    MaterialApp(
      home: MyApp()
    )
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

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
          IconButton(
              onPressed: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (c) => Upload())
                );
              }, 
              icon: Icon(Icons.add_box_outlined)
          ),
          SizedBox(width: 20),
          Icon(Icons.favorite_border),
          SizedBox(width: 20),
          Icon(Icons.send)
        ],
      ),
      body: [Board(), Text("shopping")][tab],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "search"),
        ],
        onTap: (i){
          setState(() {
            tab = i;
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}

class Board extends StatefulWidget {
  const Board({Key? key}) : super(key: key);

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {

  var data, moreData;
  var scroll = ScrollController();

  getData() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    data = jsonDecode(result.body);
  }

  addData() async {
    var moreResult = await http.get(Uri.parse('https://codingapple1.github.io/app/more1.json'));
    moreData = jsonDecode(moreResult.body);
    data.add(moreData);
  }

  @override
  void initState() {
    super.initState();
    getData();
    scroll.addListener(() {
      if(scroll.position.pixels == scroll.position.maxScrollExtent) {
        setState(() {
          addData();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(data != null) {
      return ListView.builder(
        controller: scroll,
        itemCount: data.length,
        itemBuilder: (c, i) {
          return Column(
            children: [
              Image.network(data[i]['image']),
              Row(
                children: [
                  Text("좋아요 "),
                  Text(data[i]['likes'].toString())
                ],
              ),
              Text(data[i]['user']),
              Text(data[i]['content'])
            ],
          );
        },
      );
    } else {
        return (
          Text("로딩중")
        );
    }
  }
}

class Upload extends StatelessWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instagram"),
      ),
      body: Text("new page"),
    );
  }
}

