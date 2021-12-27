import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

String strInput = "";
final txtEntrada = TextEditingController();
final txtResultado = TextEditingController();

class MiCalculadora extends StatefulWidget {
  @override
  _MiCalculadoraState createState() => _MiCalculadoraState();
}

class _MiCalculadoraState extends State<MiCalculadora> {
  @override
  void initState() {
    super.initState();
    txtEntrada.addListener(() {});
    txtResultado.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade300,
      appBar: AppBar(
        title: Text('Mi Calculadora'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: new TextField(
                decoration: new InputDecoration.collapsed(
                    hintText: "",
                    hintStyle: TextStyle(
                      fontSize: 40,
                      fontFamily: 'Raleway',
                    )),
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontFamily: 'Raleway',
                ),
                textAlign: TextAlign.right,
                controller: txtEntrada,
                onTap: () =>
                    FocusScope.of(context).requestFocus(new FocusNode()),
              )),
          new Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: new InputDecoration.collapsed(
                    hintText: "",
                    fillColor: Colors.white,
                    hintStyle: TextStyle(fontFamily: 'Raleway')),
                textInputAction: TextInputAction.none,
                keyboardType: TextInputType.number,
                style: TextStyle(
                    fontSize: 42,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                    // color: Colors.deepPurpleAccent
                    ),
                textAlign: TextAlign.right,
                controller: txtResultado,
              )),
          SizedBox(height: 40.0),
          Container(
            height: 450.0,
            child: Column( 
              children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              boton('%', const Color(0xFF708090), Colors.greenAccent),
              btnAC('AC', const Color(0xFF708090)),
              btnBorrar(),
              boton('/', const Color(0xFF708090), Colors.greenAccent),
            ],
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              boton('7', Colors.blueGrey.shade400, Colors.white),
              boton('8', Colors.blueGrey.shade400, Colors.white),
              boton('9', Colors.blueGrey.shade400, Colors.white),
              boton('*', const Color(0xFF708090), Colors.greenAccent)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              boton('4', Colors.blueGrey.shade400, Colors.white),
              boton('5', Colors.blueGrey.shade400, Colors.white),
              boton('6', Colors.blueGrey.shade400, Colors.white),
              boton('-', const Color(0xFF708090), Colors.greenAccent),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              boton('1', Colors.blueGrey.shade400, Colors.white),
              boton('2', Colors.blueGrey.shade400, Colors.white),
              boton('3', Colors.blueGrey.shade400, Colors.white),
              boton('+', const Color(0xFF708090), Colors.greenAccent),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              boton('0', Colors.blueGrey.shade400, Colors.white),
              boton('.', Colors.blueGrey.shade400, Colors.white),
              btnIgual(),
            ],
          ),
          
          SizedBox(
            height: 10.0,
          )
              ]
            )
          )
        ],
      ),
    );
  }

  Widget boton(btntxt, Color btnColor, Color colortexto) {
    
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        child: Text(
          btntxt,
          style: TextStyle(
              fontSize: 28.0, color: colortexto, fontFamily: 'Raleway'),
        ),
        onPressed: () {
          setState(() {
            txtEntrada.text = txtEntrada.text + btntxt;
          });
        },
        color: btnColor,
        padding: EdgeInsets.all(20.0),
        splashColor: Colors.white,
      ),
    );
  }

  Widget btnAC(btntext, Color btnColor) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        child: Text(
          btntext,
          style: TextStyle(
              fontSize: 28.0, color: Colors.greenAccent, fontFamily: 'Raleway'),
        ),
        onPressed: () {
          setState(() {
            txtEntrada.text = "";
            txtResultado.text = "";
          });
        },
        color: btnColor,
        padding: EdgeInsets.all(18.0),
        splashColor: Colors.white,
      ),
    );
  }

  Widget btnBorrar() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        child: Icon(Icons.backspace, size: 35, color: Colors.greenAccent),
        onPressed: () {
          txtEntrada.text = (txtEntrada.text.length > 0)
              ? (txtEntrada.text.substring(0, txtEntrada.text.length - 1))
              : "";
        },
        color: const Color(0xFF708090),
        padding: EdgeInsets.all(18.0),
        splashColor: Colors.white,
      ),
    );
  }

  Widget btnIgual() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      width: 180.0,
      child: FlatButton(
        child: Text(
          '=',
          style: TextStyle(
              fontSize: 28.0, color: Colors.greenAccent, fontFamily: 'Raleway'),
        ),
        onPressed: () {
          Parser p = new Parser();
          ContextModel cm = new ContextModel();
          Expression exp = p.parse(txtEntrada.text);
          setState(() {
            txtResultado.text =
                exp.evaluate(EvaluationType.REAL, cm).toString();
          });
        },
        color: Colors.blueGrey,
        padding: EdgeInsets.all(18.0),
        splashColor: Colors.white,
      ),
    );
  }
}
