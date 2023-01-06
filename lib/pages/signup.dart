import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;
final firestore = FirebaseAuth.instance;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final idController = TextEditingController();
  final pwController = TextEditingController();

  var userId, userPw;

  // 유저가 입력한 아이디 받기
  setUserId() {
    userId = idController.text;
    setState(() {});
  }

  // 유저가 입력한 비밀번호 받기
  setUserPw() {
    userPw = pwController.text;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    idController.addListener(setUserId);
    pwController.addListener(setUserPw);
  }

  @override
  void dispose() {
    idController.dispose();
    pwController.dispose();

    super.dispose();
  }

  signUp(userId, userPw) async {
    try {
      var result = await auth.createUserWithEmailAndPassword(
        email: userId,
        password: userPw,
      );
    } catch (e) {
      print(e);
      print("회원가입 에러입니당");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("instagram"),
        ),
        body: Column(
          children: [
            SizedBox(
              child: TextField(
                controller: idController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "아이디",
                    border: OutlineInputBorder(),
                    hintText: "이메일 형식으로 입력해주세요."),
              ),
            ),
            SizedBox(
              child: TextField(
                controller: pwController,
                decoration: InputDecoration(
                    labelText: "비밀번호",
                    border: OutlineInputBorder(),
                    hintText: "비밀번호를 6자리 이상 입력해주세요."),
              ),
            ),
            TextButton(
                onPressed: () {
                  String id = idController.text.trim().toString();
                  String pw = pwController.text.trim().toString();
                  if (id.isNotEmpty && pw.isNotEmpty) {
                    signUp(id, pw);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SingleChildScrollView(
                                child: Text("회원가입이 완료되었습니다.")),
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
                                child: Text("아이디와 비밀번호를 모두 입력하세요 !!")),
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
                child: Text("회원가입"))
          ],
        ));
  }
}
