import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _weigthController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetField(){
    _weigthController.text = "";
    _heightController.text = "";
    setState(() {
        _infoText = "Informe seus dados";
        _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate(){
    setState(() {
      double  weigth = double.parse(_weigthController.text);
      double  height = double.parse(_heightController.text) / 100;
      double imc = weigth / (height * height);
      if(imc < 18.6){
        _infoText = "Abaixo do peso imc (${imc.toStringAsPrecision(4)})";
      } else if(imc >=18.6 && imc < 24.9) {
        _infoText = "peso ideal imc (${imc.toStringAsPrecision(4)})";
      } else if(imc >=24.9 && imc < 29.9) {
        _infoText = "Levemente acimda do peso imc (${imc.toStringAsPrecision(4)})";
      } else if(imc >=29.9 && imc < 34.9) {
        _infoText = "Obesidade I imc (${imc.toStringAsPrecision(4)})";
      } else if(imc >=34.9 && imc < 39.9) {
        _infoText = "Obesidade II imc (${imc.toStringAsPrecision(4)})";
      } else if(imc >=40) {
        _infoText = "Obesidade III imc (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh), 
            onPressed: _resetField,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline, 
                color: Colors.green,
                size: 120,
              ),
              TextFormField(
                controller: _weigthController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (kG)",
                  labelStyle: TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                  )
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
                validator: (value){
                  if(value.isEmpty){
                    return "Insira seu peso";
                  }
                },
              ),
              TextFormField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                  )
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
                validator: (value){
                  if(value.isEmpty){
                    return "Insira sua altura";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top:10, bottom: 10),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),                
                    ),
                    color: Colors.green,
                  ),
                ),
              ),            
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}