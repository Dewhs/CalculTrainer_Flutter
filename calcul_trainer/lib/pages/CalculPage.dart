import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculPage extends StatefulWidget {
  static const pageRoute = "/CalculPage";
  const CalculPage(this.id, this.symbol);

  final String id;
  final String symbol;

  @override
  _CalculPageState createState() => _CalculPageState(this.id, this.symbol);
}

class _CalculPageState extends State<CalculPage> {
  _CalculPageState(this.id, this.symbol);
  final String id;
  final String symbol;
  final String Difficulty = "Easy";
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
                      'Level : ' + Difficulty,
                    ),
                  ],
                ),
              )
            ],
          ),
          Row( //Faudra créer un widget adapter à chaque operation
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "4 ",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const Text(" + ", style: TextStyle(fontSize: 35)),
              const Text(
                " 6 ",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const Text(
                " =  ",
                style: TextStyle(fontSize: 35),
              ),
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xF5F5F5F5),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: TextField(
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 35, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(top: 30.0),
                    hintText: '?',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ], // Only numbers can be entered
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
