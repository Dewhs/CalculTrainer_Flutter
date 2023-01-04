import 'package:flutter/material.dart';
//import icon

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            // Hello
            children: [
              Container(
                margin: const EdgeInsets.only(left: 25.0, bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Hello',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5.0),
                          child: Image.asset('lib/Icons/Hands_gesture.png'),
                        )
                      ],
                    ),
                    const Text(
                      'What do you want to train on ?',
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Card_Pages>[
              Card_Pages("Addition", "lib/Icons/add.png", 1),
              Card_Pages("Substraction", "lib/Icons/sub.png", 1),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Card_Pages>[
              Card_Pages("Multiplication", "lib/Icons/mult.png", 1),
              Card_Pages("Division", "lib/Icons/div.png", 1),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Card_Pages>[
              Card_Pages("Random", "lib/Icons/rdm.png", 2),
            ],
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Card_Pages extends StatefulWidget {
  const Card_Pages(this.id, this.symbol, this.unitSize);

  final String id;
  final String symbol;
  final int unitSize;

  @override
  _Card_PagesState createState() =>
      _Card_PagesState(this.id, this.symbol, this.unitSize);
}

class _Card_PagesState extends State<Card_Pages> {
  _Card_PagesState(this.id, this.symbol, this.unitSize);
  final String id;
  final String symbol;
  final int unitSize;

  double w = 160;
  @override
  Widget build(BuildContext context) {
    if (unitSize == 2) {
      w = 320 + (MediaQuery.of(context).size.width - 320) / 3;
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      margin: const EdgeInsets.only(top: 25),
      color: const Color(0xF5F5F5F5),
      elevation: 0,
      child: Container(
        height: 150,
        width: w,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(symbol),
          Container(
            height: 20,
          ),
          Text(
            id,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
      ),
    );
  }
}
