import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'home.dart';
import 'todoController.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<TodoController>.value(value: TodoController())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDo It',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          fontFamily: 'Raleway',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'ToDo It'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return _introScreen();
  }
}

Widget _introScreen() {
  return Stack(
    children: <Widget>[
      SplashScreen(
        seconds: 5,
        gradientBackground: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.orange, Colors.orange[400]],
        ),
        navigateAfterSeconds: Home(),
        loaderColor: Colors.transparent,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(child: Container(alignment: Alignment(0.0, 0.0), width: 200, child: Image.asset('assets/logo.png'))),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Text(
              "TODO IT",
              style:
                  TextStyle(color: Colors.black, fontSize: 25, decoration: TextDecoration.none, fontFamily: 'Raleway'),
            ),
          ),
        ],
      ),
    ],
  );
}
