import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'calculator-dscmec',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Calculatordsc(),
    );
  }
}

class Calculatordsc extends StatefulWidget {
  @override
  _CalculatordscState createState() => _CalculatordscState();
}

class _CalculatordscState extends State<Calculatordsc> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationfontsize = 38.0;
  double resultfontsize = 48.0;

  buttonpress(String buttontext) {
    setState(() {
      if (buttontext == "C") {
        equation="0";
        result="0";

      } else if (buttontext == "⌫") {
        equation=equation.substring(0,equation.length-1);
        if(equation==""){
          equation="0";
        }


      } else if (buttontext == "=") {
        expression=equation;
        expression=expression.replaceAll('×', '*');
        expression=expression.replaceAll('÷', '/');
        try{
          Parser p= Parser();
          Expression exp=p.parse(expression);
          ContextModel cm=ContextModel();
          result='${exp.evaluate(EvaluationType.REAL, cm)}';

        }
        catch(e) {
          result="error";
        }
        }

       else {
        if (equation == "0") {
          equation = buttontext;
        } else {
          equation = equation + buttontext;
        }
      }
    });
  }

  Widget buildbutton(
      String buttontext, double buttonheight, Color buttoncolor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonheight,
      color: buttoncolor,
      child: TextButton(
        onPressed: () {
          return buttonpress(buttontext);
        },
          child: Text(
            buttontext,
            style: TextStyle(fontSize: 30.0, color: Colors.white),
          ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(16.0),
          side: BorderSide(
            color: Colors.white,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),


      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("simple calculator"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationfontsize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 20, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultfontsize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildbutton("C", 1, Colors.redAccent),
                        buildbutton("⌫", 1, Colors.blue),
                        buildbutton("÷", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildbutton("7", 1, Colors.black54),
                        buildbutton("8", 1, Colors.black54),
                        buildbutton("9", 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildbutton("4", 1, Colors.black54),
                        buildbutton("5", 1, Colors.black54),
                        buildbutton("6", 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildbutton("1", 1, Colors.black54),
                        buildbutton("2", 1, Colors.black54),
                        buildbutton("3", 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildbutton(".", 1, Colors.black54),
                        buildbutton("0", 1, Colors.black54),
                        buildbutton("00", 1, Colors.black54),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildbutton("×", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildbutton("-", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildbutton("+", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildbutton("=", 2, Colors.redAccent),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
