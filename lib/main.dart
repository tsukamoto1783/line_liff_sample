import 'dart:js_util';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:line_liff_sample/liff/liff_func_call.dart';

Future<void> main() async {
  // LiffIDを定義したenvファイル読み込み
  await dotenv.load(fileName: "env");
  String liffID = dotenv.get("LIFFID_KEY", fallback: "LIFFID not found");

  // Liff初期化処理
  await promiseToFuture(liffInit(liffID));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyAppBody(),
    );
  }
}

class MyAppBody extends StatefulWidget {
  const MyAppBody({Key? key}) : super(key: key);
  @override
  State<MyAppBody> createState() => _MyAppBodyState();
}

class _MyAppBodyState extends State<MyAppBody> {
  static const List profileKeysList = ["userId", "displayName", "pictureUrl"];
  Map profileMap = {"userId": "", "displayName": "", "pictureUrl": ""};
  List? profile;

  @override
  void initState() {
    super.initState();
    Future(() async {
      // profile情報の取得
      profile = await promiseToFuture(liffGetProfile());

      // 取得したprofile情報をMapに格納
      for (int i = 0; i < profile!.length; i++) {
        profileMap.update(profileKeysList[i], (value) => profile![i]);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LINE LIFF sample app'),
      ),
      body: Center(
        child: (profile == null)
            ? const Text("profile is null")
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("ユーザーID: ${profileMap["userId"]}"),
                  Text("ユーザー名: ${profileMap["displayName"]}"),
                  const Text("トプ画:↓"),
                  SizedBox(
                    width: 250.0,
                    height: 250.0,
                    child: Image.network(profileMap["pictureUrl"]),
                  )
                ],
              ),
      ),
    );
  }
}
