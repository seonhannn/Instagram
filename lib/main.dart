import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'style.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

void main() {
  runApp(MaterialApp(theme: theme, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;
  var i = 0;
  var userImage, userContent;
  var scroll = ScrollController();
  var data = [];
  var boards = 10;
  var follower = 100;
  var following = 100;

  // 스크롤
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      scrollListener();
    });

    getData();
    super.initState();
  }

  scrollListener() {
    if (scroll.position.pixels == scroll.position.maxScrollExtent) {}
  }

  // 데이터 가져오기
  getData() async {
    var result = await rootBundle.loadString('assets/data.json');
    var result2 = jsonDecode(result);
    setState(() {
      data = result2;
    });
  }

  // 좋아요 수 변경하기
  clickLike(i) {
    if (data[i]["liked"] == false) {
      data[i]["likes"]++;
      data[i]["liked"] = true;
    } else {
      data[i]["likes"]--;
      data[i]["liked"] = false;
    }
    setState(() {});
  }

  // 팔로우하기
  follow() {
    follower++;
    setState(() {});
  }

  // 글 내용 입력받기
  setUserContent(text) {
    userContent = text;

    setState(() {});
  }

  // 게시글 데이터 추가하기
  addBoard() {
    var addData = {
      "id": data.length,
      "image": userImage,
      "likes": 5,
      "date": "230104",
      "content": userContent,
      "liked": false,
      "user": "${data.length}번 유저"
    };

    data.insert(0, addData);

    setState(() {});
  }

  // 이미지 가져오기
  getImage() async {
    var picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      userImage = image.path;
      userContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("instagram"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddBoard(
                          getImage: getImage,
                          userContent: userContent,
                          data: data,
                          setUserContent: setUserContent)));
            },
          )
        ],
      ),
      body: [
        Board(
            userImage: userImage,
            scroll: scroll,
            data: data,
            clickLike: clickLike),
        Profile(
            boards: boards,
            following: following,
            follower: follower,
            follow: follow)
      ][tab],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) {
          tab = i;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile")
        ],
      ),
    );
  }
}

class Board extends StatefulWidget {
  Board(
      {super.key,
      required this.userImage,
      required this.scroll,
      required this.data,
      required this.clickLike});

  final userImage, scroll, data, clickLike;

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(50),
      itemBuilder: ((BuildContext c, int i) {
        print(i);
        if (i < 0 || i >= widget.data.length) {
          return Text("null");
        } else {
          return Container(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
            child: Column(
              children: [
                Image.asset(
                  widget.data[i]["image"],
                  height: 400,
                  width: 400,
                  fit: BoxFit.fill,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          widget.clickLike(i);
                        },
                        icon: Icon(Icons.favorite)),
                    Text(widget.data[i]["likes"].toString())
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.data[i]["user"]),
                    Text(widget.data[i]["content"])
                  ],
                ),
              ],
            ),
          );
        }
      }),
      itemCount: widget.data.length,
    );
  }
}

class Profile extends StatefulWidget {
  const Profile(
      {super.key,
      required this.boards,
      required this.follower,
      required this.following,
      required this.follow});

  final boards, following, follower, follow;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset("./assets/snowman.jpg"),
            Column(
              children: [Text(widget.boards.toString()), Text("게시물")],
            ),
            Column(
              children: [Text(widget.follower.toString()), Text("팔로워")],
            ),
            Column(
              children: [Text(widget.following.toString()), Text("팔로잉")],
            )
          ],
        ),
        TextButton(
          onPressed: () {
            widget.follow();
          },
          child: Text("팔로우"),
        ),
        Expanded(
            child: GridView.builder(
          padding: EdgeInsets.all(40),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
          itemBuilder: (context, index) {
            return Container(
              child: Image.asset(
                "assets/snowman.jpg",
                width: 20,
                height: 20,
                fit: BoxFit.fill,
              ),
            );
          },
          itemCount: widget.boards,
        ))
      ],
    );
  }
}

class AddBoard extends StatefulWidget {
  const AddBoard(
      {super.key,
      required this.getImage,
      required this.userContent,
      required this.data,
      required this.setUserContent});

  final data, setUserContent, getImage, userContent;

  @override
  State<AddBoard> createState() => _AddBoardState();
}

class _AddBoardState extends State<AddBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            child: TextField(
              onChanged: (value) {
                widget.setUserContent();
              },
              decoration: InputDecoration(labelText: "글 내용을 입력해주세요"),
            ),
            width: 600,
            height: 100,
          ),
          IconButton(
              onPressed: () {
                widget.getImage();
              },
              icon: Icon(Icons.add)),
          IconButton(
              onPressed: () {
                widget.setUserContent();
              },
              icon: Icon(Icons.save)),
        ],
      ),
    );
  }
}
