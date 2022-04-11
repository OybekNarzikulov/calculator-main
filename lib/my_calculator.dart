import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyCalculator extends StatefulWidget {
  const MyCalculator({Key? key}) : super(key: key);

  @override
  _MyCalculatorState createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  String equation = '0';
  String result = '0';
  String expression = '';
  double equationFontSize = 30.0;
  double resultFontSize = 50.0;
  String prev_button = '';

  calculation(String buttonText) {
    setState(() {
      if (buttonText == 'AC') {
        equation = '0';
        result = '0';
        double equationFontSize = 50.0;
        double resultFontSize = 70.0;
      } else if (equation == '0' &&
          (buttonText == '/' ||
              buttonText == 'x' ||
              buttonText == '+' ||
              buttonText == '-' ||
              buttonText == '=')) {
        equation = '0';
        result = '0';
        double equationFontSize = 50.0;
        double resultFontSize = 70.0;
      } else if (buttonText == '+/-') {
        if (double.parse(equation) > 0.0) {
          result = (double.parse(equation) * -1).toString();
          equation = result;
        } else if (double.parse(equation) < 0.0) {
          result = (double.parse(equation) * -1).toString();
          equation = result;
        }
      } else if (buttonText == '%') {
        equation = (double.parse(equation) / 100).toString();
      } else if (buttonText == '=') {
        double equationFontSize = 50.0;
        double resultFontSize = 70.0;
        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('/', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          equation = result;
        } catch (e) {
          result = 'ERROR';
        }
      } else {
        if (equation == '0') {
          equation = '';
        } else if ((buttonText == '+' ||
                buttonText == '-' ||
                buttonText == 'x' ||
                buttonText == '/') &&
            (prev_button == '+' ||
                prev_button == '-' ||
                prev_button == 'x' ||
                prev_button == '/')) {
          equation = equation.substring(0, equation.length - 1);
        }
          equation = equation + buttonText;
          prev_button = buttonText;

      }
    });
  }

  Widget calcbutton(String buttonText, Color buttonColor, Color textColor,
      double textSize, double padding) {
    return Container(
      child: RaisedButton(
        onPressed: () => calculation(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: textSize,
            color: textColor,
          ),
        ),
        shape: CircleBorder(),
        color: buttonColor,
        padding: EdgeInsets.all(padding),
      ),
    );
  }
  Widget calcbutton_2(
      String buttonText, Color buttonColor, Color textColor, double textSize) {
    return Container(
      child: RaisedButton(
        onPressed: () => calculation(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: textSize,
            color: textColor,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: buttonColor,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      ),
    );
  }

  Widget rows(
      {required double textSize,
      required double widthOfPadding,
      required String output}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.only(right: widthOfPadding),
          width: MediaQuery.of(context).size.width * 0.9,
          alignment: Alignment.centerRight,
          child: SizedBox(
            height: 50,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                output,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: textSize,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //Calculator
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Calculator display
            MediaQuery.of(context).orientation == Orientation.landscape
                ? Column(
                    children: [
                      rows(textSize: 30, widthOfPadding: 50, output: equation),
                      rows(textSize: 40, widthOfPadding: 50, output: result),
                    ],
                  )
                : Column(
                    children: [
                      rows(
                          textSize: equationFontSize,
                          widthOfPadding: 20,
                          output: equation),
                      rows(
                          textSize: resultFontSize,
                          widthOfPadding: 20,
                          output: result),
                    ],
                  ),
            const SizedBox(
              height: 30,
            ),
            MediaQuery.of(context).orientation == Orientation.portrait
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          calcbutton('AC', Colors.grey, Colors.black, 35, 20),
                          calcbutton('+/-', Colors.grey, Colors.black, 35, 20),
                          calcbutton('%', Colors.grey, Colors.black, 35, 20),
                          calcbutton(
                              '/', Colors.amber.shade700, Colors.white, 35, 20),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          calcbutton(
                              '7', Colors.grey.shade800, Colors.white, 35, 20),
                          calcbutton(
                              '8', Colors.grey.shade800, Colors.white, 35, 20),
                          calcbutton(
                              '9', Colors.grey.shade800, Colors.white, 35, 20),
                          calcbutton(
                              'x', Colors.amber.shade700, Colors.white, 35, 20),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          calcbutton(
                              '4', Colors.grey.shade800, Colors.white, 35, 20),
                          calcbutton(
                              '5', Colors.grey.shade800, Colors.white, 35, 20),
                          calcbutton(
                              '6', Colors.grey.shade800, Colors.white, 35, 20),
                          calcbutton(
                              '-', Colors.amber.shade700, Colors.white, 35, 20),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          calcbutton(
                              '1', Colors.grey.shade800, Colors.white, 35, 20),
                          calcbutton(
                              '2', Colors.grey.shade800, Colors.white, 35, 20),
                          calcbutton(
                              '3', Colors.grey.shade800, Colors.white, 35, 20),
                          calcbutton(
                              '+', Colors.amber.shade700, Colors.white, 35, 20),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          //this is button Zero
                          RaisedButton(
                            padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                            onPressed: () {
                              calculation('0');
                            },
                            shape: const StadiumBorder(),
                            child: const Text(
                              '0',
                              style:
                                  TextStyle(fontSize: 35, color: Colors.white),
                            ),
                            color: Colors.grey[850],
                          ),
                          calcbutton(
                              '.', Colors.grey.shade800, Colors.white, 35, 20),
                          calcbutton(
                              '=', Colors.amber.shade700, Colors.white, 35, 20),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          calcbutton_2('7', Colors.grey, Colors.black, 20),
                          calcbutton_2('8', Colors.grey, Colors.black, 20),
                          calcbutton_2('9', Colors.grey, Colors.black, 20),
                          calcbutton_2(
                              'AC', Colors.amber.shade700, Colors.white, 20),
                          calcbutton_2(
                              '+/-', Colors.amber.shade700, Colors.white, 20),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          calcbutton_2(
                              '4', Colors.grey.shade800, Colors.white, 20),
                          calcbutton_2(
                              '5', Colors.grey.shade800, Colors.white, 20),
                          calcbutton_2(
                              '6', Colors.grey.shade800, Colors.white, 20),
                          calcbutton_2(
                              '%', Colors.amber.shade700, Colors.white, 20),
                          calcbutton_2(
                              '/', Colors.amber.shade700, Colors.white, 20),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          calcbutton_2(
                              '1', Colors.grey.shade800, Colors.white, 20),
                          calcbutton_2(
                              '2', Colors.grey.shade800, Colors.white, 20),
                          calcbutton_2(
                              '3', Colors.grey.shade800, Colors.white, 20),
                          calcbutton_2(
                              'x', Colors.amber.shade700, Colors.white, 20),
                          calcbutton_2(
                              '-', Colors.amber.shade700, Colors.white, 20),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          //this is button Zero
                          RaisedButton(
                            padding: EdgeInsets.fromLTRB(205, 10, 205, 10),
                            onPressed: () {
                              calculation('0');
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text(
                              '0',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            color: Colors.grey[850],
                          ),
                          calcbutton_2(
                              '+', Colors.grey.shade800, Colors.white, 20),
                          calcbutton_2(
                              '=', Colors.amber.shade700, Colors.white, 20),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
