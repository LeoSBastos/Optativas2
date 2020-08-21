import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _informacao = "Digite os valores";
  TextEditingController taxaController = TextEditingController();
  TextEditingController valorBrutoController = TextEditingController();

  _limparFormulario(){
    taxaController.text = "";
    valorBrutoController.text = "";
    setState(() {
      _informacao = "Digite os valores";
    });
    _formKey = GlobalKey<FormState>();
  }
  _calcular(){
    setState(() {
      double taxa = double.parse(taxaController.text);
      double valorBruto = double.parse(valorBrutoController.text);
      double desconto = valorBruto*(taxa/100.0);
      double valorLiquido = valorBruto - desconto;
      _informacao = "Valor bruto: ${valorBruto.toStringAsFixed(2)} \n"+
      "Desconto: ${desconto.toStringAsPrecision(2)} \n "+
          "Valor líquido: ${valorLiquido.toStringAsFixed(2)}";
    });
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagamento de autonomo"),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _limparFormulario,)
      ]),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget> [
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Taxa",
                  labelStyle: TextStyle(color: Colors.orangeAccent),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 18,
                ),
                controller: taxaController,
                validator: (value) {
                  if(value.isEmpty) {
                    return "Valor da Taxa não pode ser nulo";
                  }
                  try{
                    double.parse(value);
                  }catch(e){
                    return "Valor inválido";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Valor bruto",
                  labelStyle: TextStyle(color: Colors.orangeAccent),
              ),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 18),
              controller: valorBrutoController),
              Padding(
                padding: EdgeInsets.only(top:10.0, bottom: 10.0),
                child: RaisedButton(
                  onPressed: () {
                    if(_formKey.currentState.validate()){
                      _calcular();
                    }
                  },
                  child: Text(
                    "Calcular",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0
                    ),
                  ),
                  color: Colors.orangeAccent,
                ),
              ),
              Text(
                _informacao,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.orangeAccent, fontSize: 18.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}