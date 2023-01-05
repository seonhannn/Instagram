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
  addBoard(userImage, String userContent) {
    var addData = {
      "id": data.length,
      "image": userImage,
      "likes": 10000,
      "date": "230105",
      "content": userContent,
      "liked": false,
      "user": "${data.length + 1}번 유저"
    };

    print(addData);

    data.add(addData);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("instagram"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddBoard(
                            addBoard: addBoard,
                            setUserContent: setUserContent,
                            userContent: userContent,
                            data: data,
                          )));

              print(data);
            },
          )
        ],
      ),
      body: [
        Board(scroll: scroll, data: data, clickLike: clickLike),
        Profile(
            following: following,
            follower: follower,
            follow: follow,
            data: data)
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
      required this.scroll,
      required this.data,
      required this.clickLike});

  final scroll, data, clickLike;

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
      required this.follower,
      required this.following,
      required this.follow,
      required this.data});

  final following, follower, follow, data;

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
            Column(
              children: [Text(widget.data.length.toString()), Text("게시물")],
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
          itemCount: widget.data.length,
        ))
      ],
    );
  }
}

class AddBoard extends StatefulWidget {
  const AddBoard(
      {super.key,
      required this.addBoard,
      required this.setUserContent,
      required this.userContent,
      required this.data});

  final setUserContent, addBoard, userContent, data;

  @override
  State<AddBoard> createState() => _AddBoardState();
}

class _AddBoardState extends State<AddBoard> {
  final myController = TextEditingController();
  String userImage = "";

  // 글 저장하기
  setContent() {
    widget.setUserContent(myController.text);
  }

  @override
  void initState() {
    super.initState();
    myController.addListener(setContent);
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  // 이미지 가져오기
  getImage() {
    userImage = "assets/snowman.jpg";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("instagram"),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
            },
          )
        ],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  getImage();
                  print(userImage);
                  if (userImage != null) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SingleChildScrollView(
                                child: Text("이미지가 저장되었습니다.")),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("확인"))
                            ],
                          );
                        });
                  } else {
                    print("이미지 없음");
                  }
                },
                icon: Icon(Icons.add_a_photo)),

            // save !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            IconButton(
                onPressed: () {
                  if (myController.text.trim.toString().isNotEmpty &&
                      userImage.isNotEmpty) {
                    widget.addBoard(
                        userImage, myController.text.trim().toString());
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content:
                                SingleChildScrollView(child: Text("저장 됐어용")),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("확인"))
                            ],
                          );
                        });
                    /*
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()));
                        */
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SingleChildScrollView(
                                child: Text("글과 사진을 모두 입력해야합니다")),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("확인"))
                            ],
                          );
                        });
                  }
                },
                icon: Icon(Icons.save))
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 500,
              child: TextField(
                controller: myController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "글 내용을 입력해주세요.", border: OutlineInputBorder()),
              ),
            ),
            IconButton(
                onPressed: () {
                  String text = myController.text.trim().toString();
                  if (text.isNotEmpty) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SingleChildScrollView(
                                child: Text("글이 입력되었습니다.")),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("확인"))
                            ],
                          );
                        });
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SingleChildScrollView(
                                child: Text("글을 입력해주세요.")),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("확인"))
                            ],
                          );
                        });
                  }
                },
                icon: Icon(Icons.arrow_circle_right))
          ],
        ),
        TextButton(
            onPressed: () {
              if (userImage != null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content:
                            SingleChildScrollView(child: Text("사진이 있습니다.")),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("확인"))
                        ],
                      );
                    });
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content:
                            SingleChildScrollView(child: Text("사진이 없습니다.")),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("확인"))
                        ],
                      );
                    });
              }
            },
            child: Text("이미지 확인"))
      ]),
    );
  }
}
