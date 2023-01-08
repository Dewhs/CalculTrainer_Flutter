import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

// --- global ---
int number1 = 0;
int number2 = 0;
int nbCalculTotal = 0;
int nbCalculValidate = 0;

String id = "";
String difficulty = "";

class CalculPage extends StatefulWidget {
  static const pageRoute = "/CalculPage";
  const CalculPage(this.id, this.symbol);

  final id;
  final String symbol;

  @override
  _CalculPageState createState() => _CalculPageState(this.id, this.symbol);
}

class _CalculPageState extends State<CalculPage> {
  _CalculPageState(this.id, this.symbol);
  final id;
  final String symbol;
  final difficulty = "Easy";

  void actualiseWidget() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 25.0, bottom: 10),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 5, bottom: 5, right: 25),
                          child: Text(
                            '$nbCalculTotal Total',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 5, bottom: 5, right: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '$nbCalculValidate ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              Image.asset(
                                'lib/Icons/validate.png',
                                width: 25,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
          Row(
            // Hello
            children: [
              Container(
                margin: const EdgeInsets.only(left: 25.0, bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      id,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Level : $difficulty',
                    ),
                  ],
                ),
              )
            ],
          ),
          OperationWidget(id, difficulty, actualiseWidget),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Container(
                  margin: const EdgeInsets.only(left: 10,top: 50,right: 10),
                  width: 100,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(245, 240, 240, 240),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Finish',
                        style: TextStyle(fontWeight: FontWeight.bold),),
                      ]),
                ),
              ),
              GestureDetector(
                child: Container(
                  margin: const EdgeInsets.only(left: 10,top: 50,right: 10),
                  width: 100,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 194, 255, 204),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Next',
                        style: TextStyle(fontWeight: FontWeight.bold),),
                      ]),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class OperationWidget extends StatefulWidget {
  const OperationWidget(this.id, this.difficulty, this.actualiseWidget);
  final Function actualiseWidget;

  final String id;
  final String difficulty;

  @override
  _OperationWidgetState createState() =>
      _OperationWidgetState(this.id, this.difficulty, this.actualiseWidget);
}

class _OperationWidgetState extends State<OperationWidget> {
  _OperationWidgetState(this.id, this.difficulty, this.actualiseWidget);
  final id;
  final difficulty;
  final fieldText = TextEditingController();
  final Function actualiseWidget;
  FocusNode _focusNode = FocusNode();

  void refreshOperation() {
    var rdm = Random();
    if (difficulty == "Easy") {
      number1 = rdm.nextInt(9);
      number2 = rdm.nextInt(9);
    }
    if (difficulty == "Intermediate") {
      number1 = 10 + rdm.nextInt(89);
      number2 = 10 + rdm.nextInt(89);
    }
    if (difficulty == "Expert") {
      number1 = 100 + rdm.nextInt(899);
      number2 = 100 + rdm.nextInt(899);
    }
  }

  @override
  void initState() {
    super.initState();
    refreshOperation();
  }

  @override
  Widget build(BuildContext context) {
    if (id == "Addition") {
      return Row(
        //Faudra créer un widget adapter à chaque operation
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number1.toString(),
            style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
          const Text("  +  ", style: TextStyle(fontSize: 35)),
          Text(
            number2.toString(),
            style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
          const Text(
            "  =  ",
            style: TextStyle(fontSize: 35),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: Color.fromARGB(245, 240, 240, 240),
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: TextField(
              focusNode: _focusNode,
              autofocus: true,
              controller: fieldText,
              onSubmitted: (value) {
                setState(() {
                  nbCalculTotal++;
                  if (verifyReslut(id, value)) nbCalculValidate++;
                  _focusNode.requestFocus();
                  refreshOperation();
                  fieldText.clear();
                  actualiseWidget();
                });
              },
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 30.0),
                hintText: '?',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
            ),
          )
        ],
      );
    }
    return const Text("En cours de construction...");
  }
}

bool verifyReslut(String id, String _value) {
  if (_value == "") {
    return false;
  }

  int value = int.parse(_value);

  if (id == "Addition") {
    print(checkAddResult(value));
    return checkAddResult(value);
  }
  return false;
}

bool checkAddResult(int value) {
  return (number1 + number2) == value;
}
