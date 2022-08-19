import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';

var userInfo;

Future<void> main() async {
  await FlutterLineLiff().init(
    config: Config(liffId: '1657390584-p2Ar7vyL'),
    successCallback: () {
      debugPrint('LIFF init success.');
    },
    errorCallback: (error) {
      debugPrint(
          'LIFF init error: ${error.name}, ${error.message}, ${error.stack}');
    },
  );
  // FlutterLineLiff().ready.then((_) {
  //   // SDK is ready now.
  //   final JWTPayload? decodedIDToken = FlutterLineLiff().getDecodedIDToken();
  //   debugPrint(decodedIDToken.toString());
  //
  //   final String? id = FlutterLineLiff().id;
  //   debugPrint(id);
  //
  //   final String? idToken = FlutterLineLiff().getIDToken();
  //   debugPrint(idToken);
  //
  //   debugPrint('ready ok');
  // });
  //
  // final Profile profile = await FlutterLineLiff().profile;
  // debugPrint(profile.displayName);
  // debugPrint('test1');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;
  Profile? userInfo;

  Future<void> getProfiles() async {
    userInfo = await FlutterLineLiff().profile;
    debugPrint(userInfo.toString());
    debugPrint('test1');
  }

  @override
  void initState() {
    FlutterLineLiff().ready.then((_) {
      getProfiles();
      debugPrint('test3');
    });
    super.initState();
    setState(() {});
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('test2');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(userInfo.toString()),
            Text(FlutterLineLiff().id!),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
