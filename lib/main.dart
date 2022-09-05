import 'package:flutter/material.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

JWTPayload? decodedIDToken;

Future<void> main() async {
  await dotenv.load(fileName: "env");
  await FlutterLineLiff().init(
    config: Config(liffId: dotenv.env['LIFFID_KEY'].toString()),
    successCallback: () {
      decodedIDToken = FlutterLineLiff().getDecodedIDToken();
      debugPrint('LIFF init success.');
    },
    errorCallback: (error) {
      debugPrint(
          'LIFF init error: ${error.name}, ${error.message}, ${error.stack}');
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('LINE LIFF sample app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text("↓Profile Picture"),
              Image.asset(
                'images/cat_sample.jpeg',
                width: 200.0,
                height: 200.0,
              ),
              const Text("User Name:           ゆーと"),
              const Text("User ID:                  TestLineID123456789"),
              const Text("Status Message: ステータスメッセージ(設定してるなら)"),
            ],
          ),
        ),
      ),
    );
  }
}
