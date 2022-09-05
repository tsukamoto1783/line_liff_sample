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
            (userInfo == null)
                ? Text("user name: $userInfo")
                : Text("user name: $userInfo!.displayName"),
            // (decodedIDToken == null)
            //     ? Text(decodedIDToken.toString())
            //     : Text(decodedIDToken!.name.toString()),
            // Text(FlutterLineLiff().id!),
          ],
        ),
      ),
    );
  }
}
