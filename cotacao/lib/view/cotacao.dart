import 'package:cotacao/component/criar_textfield.dart';
import 'package:cotacao/controller/controller.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Controller _controller = Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("\$ Cotação \$"),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: FutureBuilder<Map>(
            future: _controller.requisicao.getDados(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                      child: Text("Carregando dados",
                          style: TextStyle(color: Colors.amber, fontSize: 25.0),
                          textAlign: TextAlign.center));
                default:
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      "Erro ao carregar dados",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    _controller.dolar =
                        snapshot.data["results"]["currencies"]["USD"]["buy"];
                    _controller.euro =
                        snapshot.data["results"]["currencies"]["EUR"]["buy"];
                    _controller.bitCoin = snapshot.data["results"]["bitcoin"]
                        ["blockchain_info"]["buy"];
                    return SingleChildScrollView(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Icon(
                                Icons.monetization_on,
                                size: 150.0,
                                color: Colors.amber,
                              ),
                              buildTextField(
                                  "Reais",
                                  "R\$",
                                  _controller.realController,
                                  _controller.realChanged),
                              Divider(),
                              buildTextField(
                                  "Dólares",
                                  "US\$",
                                  _controller.dolarController,
                                  _controller.dolarChanged),
                              Divider(),
                              buildTextField(
                                  "Euros",
                                  "€",
                                  _controller.euroController,
                                  _controller.euroChanged),
                              Divider(),
                              buildTextField(
                                  "Bitcoin",
                                  "₿",
                                  _controller.bitCoinController,
                                  _controller.bitCoinChanged)
                            ]));
                  }
              }
            }));

    // SingleChildScrollView(
    //   padding: EdgeInsets.all(10.0),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: <Widget>[
    //       Icon(
    //         Icons.monetization_on,
    //         size: 150.0,
    //         color: Colors.amber,
    //       ),
    //       buildTextField(
    //           "Reais", "R\$", _controller.realController, (String text) {}),
    //       Divider(),
    //       buildTextField("Dólares", "US\$", _controller.dolarController,
    //           (String text) {}),
    //       Divider(),
    //       buildTextField(
    //           "Euros", "€", _controller.euroController, (String text) {}),
    //       Divider(),
    //       buildTextField(
    //           "Bitcoin", "₿", _controller.bitCoinController, (String text) {})
    //     ],
    //   ),
    // ),
  }
}
