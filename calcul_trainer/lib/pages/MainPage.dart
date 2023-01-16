import 'package:calcul_trainer/pages/CalculPage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import icon

class MyHomePage extends StatelessWidget {
  static const pageRoute = "/";
  MyHomePage({super.key, required this.title}) {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    Future<String> _difficulty = _prefs.then((SharedPreferences prefs) async {
      try {
        print(prefs.getString('difficulty')!.toString());
        difficulty = prefs.getString('difficulty')!.toString();
        return prefs.getString('difficulty')!;
      } catch (e) {
        print('getDifficulty : $e');
        difficulty = listDifficulty.first;
        return difficulty;
      }
    });
  }
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
                    helloWidget,
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
            children: const <CardPages>[
              CardPages("Addition", "lib/Icons/add.png", 1),
              CardPages("Substraction", "lib/Icons/sub.png", 1),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <CardPages>[
              CardPages("Multiplication", "lib/Icons/mult.png", 1),
              CardPages("Division", "lib/Icons/div.png", 1),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <CardPages>[
              CardPages("Random", "lib/Icons/rdm.png", 2),
            ],
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CardPages extends StatefulWidget {
  const CardPages(this.id, this.symbol, this.unitSize);

  final String id;
  final String symbol;
  final int unitSize;

  @override
  CardPagesState createState() =>
      CardPagesState(this.id, this.symbol, this.unitSize);
}

class CardPagesState extends State<CardPages> {
  CardPagesState(this.id, this.symbol, this.unitSize);
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
                color: Colors.black,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

Widget helloWidget = Row(
  children: [
    const Text(
      'Hello',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
    Container(
      margin: const EdgeInsets.only(left: 5.0),
      child: Image.asset('lib/Icons/Hands_gesture.png'),
    )
  ],
);
