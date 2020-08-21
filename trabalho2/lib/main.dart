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
  TextEditingController nomeController = TextEditingController();
  TextEditingController salarioBrutoController = TextEditingController();

  _limparFormulario(){
    nomeController.text = "";
    salarioBrutoController.text = "";
    setState(() {
      _informacao = "Digite os valores";
    });
    _formKey = GlobalKey<FormState>();
  }
  _calcular(){
    setState(() {
      String nome = nomeController.text;
      double valorBruto = double.parse(salarioBrutoController.text);
      double desconto;
      double taxa;
      if(valorBruto<=1045.00){
        taxa = 0.075;
        desconto = valorBruto * taxa;
      } else if (valorBruto <= 2089.60) {
        taxa = 0.09;
        desconto = valorBruto * taxa;
      } else if (valorBruto <= 3134.40){
        taxa = 0.12;
        desconto = valorBruto * taxa;
      } else if (valorBruto <= 6101.06){
        taxa = 0.14;
        desconto = valorBruto * taxa;
      } else {
        taxa = 0.14;
        desconto = 6101.6 * taxa;
      }
      double valorLiquido = valorBruto - desconto;
      _informacao = "Nome: ${nome} \n"+
          "Valor Bruto: R\$ ${valorBruto.toStringAsFixed(2)} \n"+
          "Desconto: R\$ ${desconto.toStringAsPrecision(2)} (${(taxa*100).toString()}%)\n "+
          "Valor líquido: R\$ ${valorLiquido.toStringAsFixed(2)}";
    });
  }

  String _nomeValidator(value) {
    if(value.isEmpty) {
      return "Nome não pode ser nulo";
    }
  }

  String _salarioValidator(value) {
    if(value.isEmpty) {
      return "Salario não pode ser nulo";
    }
    try{
      double.parse(value);
    }catch(e){
      return "Valor inválido";
    }
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Calculo de Alíquota"),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(255, 0, 255, 1),
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
                  labelText: "Nome",
                  labelStyle: TextStyle(color: Colors.teal),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                controller: nomeController,
                validator: _nomeValidator
              ),
              TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Salario bruto",
                    labelStyle: TextStyle(color: Colors.teal),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18),
                  controller: salarioBrutoController,
              validator: _salarioValidator),
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
                  color: Colors.red,
                ),
              ),
              Text(
                _informacao,
                textAlign: TextAlign.center,
                style: TextStyle(color: Color.fromRGBO(255, 0, 255, 1), fontSize: 18.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}