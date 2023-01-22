import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:async';

// --- global ---
int number1 = 0;
int number2 = 0;
int nbCalculTotal = 0;
int nbCalculValidate = 0;

String operationId = "";
String difficulty = "";

FocusNode _focusNode = FocusNode();
const List<String> listDifficulty = <String>['Easy', 'Intermediate', 'Expert'];
String dropdownValue = listDifficulty.first;

class CalculPage extends StatefulWidget {
  static const pageRoute = "/CalculPage";
  const CalculPage(this.id, this.symbol);

  final id;
  final String symbol;

  @override
  CalculPageState createState() => CalculPageState(this.id, this.symbol);
}

class CalculPageState extends State<CalculPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  CalculPageState(this.id, this.symbol) {
    dropdownValue = difficulty;
    operationId = id;
    refreshOperation();
    print("difficulty : $difficulty");
  }

  final id;
  final String symbol;

  final fieldText = TextEditingController();

  void refreshOperation() {
    var rdm = Random();
    if (difficulty == "Easy") {
      number1 = rdm.nextInt(9);
      number2 = 1 + rdm.nextInt(8);
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

  void actualiseWidget() {
    setState(() {
      _focusNode.requestFocus();
      refreshOperation();
      fieldText.clear();
    });
  }

  void validateReply() {
    nbCalculTotal++;
    if (verifyReslut(operationId, fieldText.text)) nbCalculValidate++;
    actualiseWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
              top: 50,
              left: 25.0,
              bottom: 10,
            ),
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
                    Row(
                      children: [
                        const Text(
                          'Level : ',
                        ),
                        DropdownButton<String>(
                          value: dropdownValue,
                          items: listDifficulty
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              dropdownValue = value!;
                              difficulty = dropdownValue;
                              _prefs.then((SharedPreferences prefs) async {
                                await prefs
                                    .setString('difficulty', difficulty)
                                    .catchError((e, st) {
                                  print(e);
                                });
                              });
                            });
                            refreshOperation();
                          },
                          underline: Container(),
                          borderRadius: BorderRadius.circular(15),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          //OperationWidget(id, difficulty, actualiseWidget),
          Row(
            //Faudra créer un widget adapter à chaque operation
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                number1.toString(),
                style:
                    const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SymbolWidget(
                id: id,
              ),
              Text(
                number2.toString(),
                style:
                    const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
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
                  cursorColor: const Color.fromARGB(255, 37, 37, 37),
                  controller: fieldText,
                  onSubmitted: (value) => validateReply(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 30.0),
                      //hintText: '?',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      )),
                  keyboardType: TextInputType.number,
                ),
              )
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Container(
                  margin: const EdgeInsets.only(left: 10, top: 50, right: 10),
                  width: 100,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(245, 240, 240, 240),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: Image.asset(
                            'lib/Icons/finishFlag.png',
                            width: 15,
                          ),
                        ),
                        const Text(
                          'Finish',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ]),
                ),
              ),
              GestureDetector(
                onTap: () => validateReply(),
                child: Container(
                  margin: const EdgeInsets.only(left: 10, top: 50, right: 10),
                  width: 100,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 194, 255, 204),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Next',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(),
                          child: Image.asset(
                            'lib/Icons/rightArrow.png',
                            width: 25,
                          ),
                        )
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

class SymbolWidget extends StatelessWidget {
  const SymbolWidget({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    if (id == "Addition") {
      return const Text("  +  ", style: TextStyle(fontSize: 35));
    } else if (id == "Substraction") {
      return const Text("  -  ", style: TextStyle(fontSize: 35));
    } else if (id == "Multiplication") {
      return const Text("  x  ", style: TextStyle(fontSize: 35));
    } else if (id == "Division") {
      return const Text('  /  ', style: TextStyle(fontSize: 35));
    } else if (id == "Random") {
      var rdm = Random();
      List<String> symbol = [
        "Addition",
        "Substraction",
        "Multiplication",
        "Division"
      ];
      operationId = symbol[rdm.nextInt(symbol.length)];
      return SymbolWidget(id: operationId);
    }

    return const Text('is there a Little problem ?');
  }
}

bool verifyReslut(String id, String _value) {
  if (_value == "") {
    return false;
  }

  double doubleValue = double.parse(_value);
  if (id == "Division") {
    return checkDivResult(doubleValue);
  }
  int value;
  try {
    value = int.parse(_value);
  } catch (e) {
    return false;
  }

  if (id == "Addition") {
    return checkAddResult(value);
  }
  if (id == "Substraction") {
    return checkSubResult(value);
  }
  if (id == "Multiplication") {
    return checkMultResult(value);
  }
  return false;
}

bool checkAddResult(int value) {
  return (number1 + number2) == value;
}

bool checkSubResult(int value) {
  return (number1 - number2) == value;
}

bool checkDivResult(double value) {
  double result = number1.toDouble() / number2.toDouble();
  result = (result * 1000).round() / 1000;
  value = (value * 1000).round() / 1000;

  return result == value;
}

bool checkMultResult(int value) {
  return (number1 * number2) == value;
}




/* 
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
}*/
