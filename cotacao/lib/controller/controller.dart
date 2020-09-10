import 'package:cotacao/http/requisicao_dados.dart';
import 'package:flutter/material.dart';

class Controller {
  TextEditingController _realController = TextEditingController();
  TextEditingController _dolarController = TextEditingController();
  TextEditingController _euroController = TextEditingController();
  TextEditingController _bitCoinController = TextEditingController();
  Requisicao _requisicao = Requisicao();
  double _dolar;
  double _euro;
  double _bitCoin;
  void realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    _dolarController.text = (real / _dolar).toStringAsFixed(2);
    _euroController.text = (real / _euro).toStringAsFixed(2);
    _bitCoinController.text = (real / _bitCoin).toStringAsFixed(2);
  }

  void dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    _realController.text = (dolar * this._dolar).toStringAsFixed(2);
    _euroController.text = (dolar * this._dolar / _euro).toStringAsFixed(2);
    _bitCoinController.text = (dolar / _bitCoin).toStringAsFixed(2);
  }

  void euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    _realController.text = (euro * this._euro).toStringAsFixed(2);
    _dolarController.text = (euro * this._euro / _dolar).toStringAsFixed(2);
    _bitCoinController.text = (euro / _bitCoin).toStringAsFixed(2);
  }

  void bitCoinChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double bitCoin = double.parse(text);
    _realController.text =
        (bitCoin * this._bitCoin * this._dolar).toStringAsFixed(2);
    _dolarController.text = (bitCoin * this._bitCoin).toStringAsFixed(2);
    _euroController.text =
        (bitCoin * this._bitCoin / (_euro / _dolar)).toStringAsFixed(2);
  }

  void _clearAll() {
    _realController.text = "";
    _dolarController.text = "";
    _euroController.text = "";
  }

  TextEditingController get realController => _realController;
  TextEditingController get dolarController => _dolarController;
  TextEditingController get euroController => _euroController;
  TextEditingController get bitCoinController => _bitCoinController;
  Requisicao get requisicao => _requisicao;

  double get bitCoin => _bitCoin;
  set bitCoin(double value) {
    _bitCoin = value;
  }

  double get euro => _euro;
  set euro(double value) {
    _euro = value;
  }

  double get dolar => _dolar;
  set dolar(double value) {
    _dolar = value;
  }
}
