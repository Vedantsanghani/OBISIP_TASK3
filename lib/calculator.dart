import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}
class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";

  List<String> buttonList  = [
    "AC", "(", ")", "/", "7", "8", "9", "*", "4", "5", "6", "+", "1", "2", "3", "-", "C", "0", ".", "=",
  ];
  @override
  Widget build(BuildContext context){
    return SafeArea(
        child:  Scaffold(
          backgroundColor: CupertinoColors.black,
          body: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height/3.18,
                child: resultWidget(),
              ),
              Expanded(child: buttonWidget()),
            ],
          ),
        ),
    );
  }
  Widget resultWidget(){
      return Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerRight,
              child: Text(userInput, style:  TextStyle(
                fontSize:80,
                color: Colors.white,
              ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(0),
              alignment: Alignment.centerRight,
              child: Text(result, style:  TextStyle(
                  fontSize:30,
                  fontWeight: FontWeight.bold,
              ),
              ),
            ),
          ],
        ),
      );
  }
  Widget buttonWidget(){
    return Container(
      padding: EdgeInsets.all(14),
      child: GridView.builder(itemCount: buttonList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ), itemBuilder: (context, index){
        return button(buttonList[index]);
      },),
    );
  }
  getColor(String text){
    if(text == "/" || text == "*" || text == "+" || text == "-" || text == "C"){
      return Colors.white;
    }
    if(text == "=" || text == "AC" || text == "(" || text == ")"){
      return Colors.black;
    }
    return Colors.white;
  }
  getBgColor(String text){
    if(text == "AC" || text == "(" || text == ")"){
      return Colors.grey.shade500;
    }
    if(text == "/" || text == "*" || text == "+" || text == "-" || text == "="){
      return Colors.amber.shade700;
    }
    return Colors.grey.shade800;
  }
  Widget button(String text){
    return InkWell(
      onTap: (){
        setState(() {
          handleButtonPress(text);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: getBgColor(text),
          borderRadius: BorderRadius.circular(60),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Text(text, style: TextStyle(
            color: getColor(text),
            fontSize: 35,
            // fontWeight: FontWeight.bold,
          ),),
        ),
      ),
    );
  }
  handleButtonPress(String text){
    if(text == "AC"){
      userInput = "";
      result = "0";
      return;
    }
    if(text == "C"){
      if(userInput.length > 0){
        userInput = userInput.substring(0,userInput.length-1);
        return;
      }
      else{
        return null;
      }
    }
    if(text == "="){
      result  = calculate();
      userInput = result;
      if(userInput.endsWith(".0")){
        userInput = userInput.replaceAll(".0", "");
      }
      if(result.endsWith(".0")){
        result  = result.replaceAll(".0", "");
      }
      return;
    }
    userInput = userInput + text;
  }
  String calculate(){
    try{
      var exp = Parser().parse(userInput);
      var eveluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return eveluation.toString();
    }
    catch(e){
      return "Error";
    }
  }
}