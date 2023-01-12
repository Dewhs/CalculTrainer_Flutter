import 'package:calcul_trainer/pages/CalculPage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
//import icon

class MyHomePage extends StatelessWidget {
  static const pageRoute = "/";
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
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

    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              child: CalculPage(id, symbol))),
      //onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CalculPage(id, symbol))),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        margin: const EdgeInsets.only(top: 25),
        color: const Color.fromARGB(245, 240, 240, 240),
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
      ),
    );
  }
}
