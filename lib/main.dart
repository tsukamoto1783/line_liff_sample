import 'package:flutter/material.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

JWTPayload? decodedIDToken;

Future<void> main() async {
  await dotenv.load(fileName: "assets/env");
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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
                ? Text(userInfo.toString())
                : Text(userInfo!.displayName),
            (decodedIDToken == null)
                ? Text(decodedIDToken.toString())
                : Text(decodedIDToken!.name.toString()),
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
