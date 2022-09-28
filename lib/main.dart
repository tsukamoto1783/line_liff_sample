import 'dart:js_util';
import 'package:flutter/material.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'liff_init.dart';

// jsパッケージ版でinit()までしてみる。
JWTPayload? decodedIDToken;
Future<void> main() async {
  // KEYを定義したenvファイル読み込み
  await dotenv.load(fileName: "env");
  // LIFF初期化処理
  decodedIDToken =
      await promiseToFuture(init(dotenv.env['LIFFID_KEY'].toString()));
  debugPrint(decodedIDToken.toString());
  await Future.delayed(const Duration(seconds: 2));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'LINE LIFF sample app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Profile? userInfo;

  @override
  void initState() {
    debugPrint('initState start');
    super.initState();

    Future(() async {
      userInfo = await FlutterLineLiff().profile;
      setState(() {});
      debugPrint('get Profile success');
    });

    debugPrint('initState end');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('return Scaffold start');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("=========== getProfile ==========="),
            (userInfo == null)
                ? const Text("user name: null")
                : Text("user name: ${userInfo!.displayName}"),
            (userInfo == null)
                ? const Text("")
                : Text("user name: ${userInfo!.userId}"),
            (userInfo == null)
                ? const Text("")
                : Image.network(decodedIDToken!.picture.toString()),
            (userInfo == null)
                ? const Text("")
                : Text("user name: ${userInfo!.statusMessage}"),

            const Text("=========== getDecodeIDToken ==========="),
            (decodedIDToken == null)
                ? const Text("decodedIDToken: null")
                : Text("user name: ${decodedIDToken!.name.toString()}"),
            (decodedIDToken == null)
                ? const Text("")
                : Image.network(decodedIDToken!.picture.toString()),
            // Text(FlutterLineLiff().id!),
          ],
        ),
      ),
    );
  }
}
