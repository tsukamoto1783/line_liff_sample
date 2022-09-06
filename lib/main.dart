import 'package:flutter/material.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Profile? userInfo;
Future<void> main() async {
  await dotenv.load(fileName: "env");
  await FlutterLineLiff().init(
    config: Config(liffId: dotenv.env['LIFFID_KEY'].toString()),
    successCallback: () {
      debugPrint('LIFF init success.');
    },
    errorCallback: (error) {
      debugPrint(
          'LIFF init error: ${error.name}, ${error.message}, ${error.stack}');
    },
  );
  userInfo = await FlutterLineLiff().profile;
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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (userInfo == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('LINE LIFF sample app'),
        ),
        body: const Center(
          child: Text("decodedIDToken: null"),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('LINE LIFF sample app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // // =========== getDecodeIDToken Ver. ===========
              // const Text("Profile Picture"),
              // Image.network(decodedIDToken!.picture.toString()),
              // Text("User Name: ${decodedIDToken!.name.toString()}"),

              // =========== getProfile Ver. ===========
              const Text("Profile Picture"),
              Image.network(userInfo!.pictureUrl.toString()),
              Text("User Name: ${userInfo!.displayName}"),
              Text("User ID: ${userInfo!.userId}"),
              Text("Status Message: ${userInfo!.statusMessage}"),
            ],
          ),
        ),
      );
    }
  }
}
