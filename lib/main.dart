import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  String state = "";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;

  AnimationController controller;
  Animation sizeAnimation;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();

    // Defining controller with animation duration of two seconds
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    // Defining both color and size animations
    sizeAnimation = Tween<double>(begin: 100.0, end: 200.0).animate(controller);

    // Rebuilding the screen when animation goes ahead
    controller.addListener(() {
      setState(() {});
    });

    // Repeat the animation after finish
    controller.repeat();

    //For single time
    //controller.forward()

    //Reverses the animation instead of starting it again and repeats
    //controller.repeat(reverse: true);
    schedulestop();
  }

  void schedulestart() {
    Future.delayed(const Duration(milliseconds: 400), () {
      controller.repeat();
      schedulestop();
    });
  }

  void schedulestop() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      controller.reset();
      schedulestart();
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   // title: Text(widget.title),
      // ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Stack(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: sizeAnimation.value,
                    width: sizeAnimation.value,
                    color: controller.status == AnimationStatus.forward
                        ? Colors.red
                        : Colors.blue,
                  ),
                  Container(
                    width: 400,
                    height: 100,
                    alignment: Alignment.center,
                    child: Text(
                      'Counter: ${sizeAnimation.value.toInt()}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ]),
            // if (_counter % 2 == 0)  _buildImageContainer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildImageContainer1() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Container(
        color: Colors.red.withOpacity(0.0),
      ),
    );
  }

  Widget _buildImageContainer() {
    return Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: ClipRect(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            // color: Colors.black.withOpacity(0.1),
            color:
                Colors.black.withOpacity((_counter / 2) % 2 == 0 ? 0.0 : 0.1),
          ),
        )));
    // return Container(
    //   child: BackdropFilter(
    //     filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
    //     child: Container(
    //       color: Colors.red.withOpacity(0.0),
    //     ),
    //   ),
    // );
  }
}
