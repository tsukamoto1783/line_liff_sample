import 'dart:js_util';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'liff_init.dart';

// jsパッケージ版でinit()までしてみる。
Future<void> main() async {
  // KEYを定義したenvファイル読み込み
  await dotenv.load(fileName: "env");
  String liffID = dotenv.get("LIFFID_KEY", fallback: "LIFFID not found");

  // LIFF初期化処理
  await promiseToFuture(init(liffID));

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
    debugPrint('initState start');
    super.initState();

    Future(() async {
      debugPrint('get Profile start');
      profile = await promiseToFuture(getProfile());

      // 取得したprofile情報をMapに格納
      for (int i = 0; i < profile!.length; i++) {
        profileMap.update(profileKeysList[i], (value) => profile![i]);
      }

      setState(() {});
      debugPrint('get Profile end');
    });
    debugPrint('initState end');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('return Scaffold start');

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
                  const Text("=========== Profile ==========="),
                  Text("user ID: ${profileMap["userId"]}"),
                  Text("user name: ${profileMap["displayName"]}"),
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
