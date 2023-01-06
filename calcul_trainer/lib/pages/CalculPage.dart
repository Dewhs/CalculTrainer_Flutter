import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

// --- global ---
int number1 = 0;
int number2 = 0;

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
                      'Level : ' + difficulty,
                    ),
                  ],
                ),
              )
            ],
          ),
          OperationWidget(id, difficulty),
        ],
      ),
    );
  }
}

class OperationWidget extends StatefulWidget {
  const OperationWidget(this.id, this.difficulty);

  final String id;
  final String difficulty;

  @override
  _OperationWidgetState createState() =>
      _OperationWidgetState(this.id, this.difficulty);
}

class _OperationWidgetState extends State<OperationWidget> {
  _OperationWidgetState(this.id, this.difficulty);
  final id;
  final difficulty;
  final fieldText = TextEditingController();
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
                  Verify_Reslut(id, value);
                  _focusNode.requestFocus();
                  refreshOperation();
                  fieldText.clear();
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

bool Verify_Reslut(String id, String _value) {
  if(_value == "") ()=> false;
  
  int value = int.parse(_value);
  
    if (id == "Addition") {
      print(Check_Add_Result(value));
      return Check_Add_Result(value);
    }
  return false;
}

bool Check_Add_Result(int value) {
  return (number1 + number2) == value;
}
