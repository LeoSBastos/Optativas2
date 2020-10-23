import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;

class CardItem extends StatefulWidget {
  Map _dados;
  String _country;
  CardItem(this._country, this._dados);
  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  NumberFormat nf = NumberFormat.decimalPattern("pt_BR");
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.orange[800],
        child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(children: <Widget>[
              ListTile(
                  title: Center(
                child: Text(
                  widget._country,
                  style: TextStyle(
                    fontSize: 50.0,
                  ),
                ),
              )),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Casos Confirmados do Dia: ${nf.format(widget._dados["NewConfirmed"])}",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Casos Confirmados Total: ${nf.format(widget._dados["TotalConfirmed"])}",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Mortes do Dia:  ${nf.format(widget._dados["NewDeaths"])}",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Mortes Total: ${nf.format(widget._dados["TotalDeaths"])}",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Pessoas Curadas do dia: ${nf.format(widget._dados["NewRecovered"])}",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Pessoas Curadas Total: ${nf.format(widget._dados["TotalRecovered"])}",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ]),
            ])));
  }
}
