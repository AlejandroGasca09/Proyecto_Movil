import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key, required this.title});
  final String title;

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  double _total = 0;
  double _total2 = 0;
  String _operador = "";
  bool _punto = false;
  int _contadorDecimal = 10;

  final List<List<dynamic>> _simboloTeclado = [
    [7, 8, 9, '/'],
    [4, 5, 6, '*'],
    [1, 2, 3, '-'],
    ['.', 0, '=', '+']
  ];

  void _presionaNumero(dynamic n) {
    setState(() {
      if (!_punto) {
        _total = _total * 10 + (n as int);
      } else {
        _total = _total + ((n as int) / _contadorDecimal);
        _contadorDecimal *= 10;
      }
    });
  }

  void _presionaSimbolo(String simbolo) {
    setState(() {
      if (simbolo == '.') {
        if (!_punto) {
          _punto = true;
          _contadorDecimal = 10;
        }
      } else if (simbolo == '=') {
        if (_operador.isNotEmpty) {
          _realizaOperacion();
          _operador = "";
          _total2 = 0;
        }
        _punto = false;
      } else {
        if (_operador.isNotEmpty) {
          _realizaOperacion();
        } else {
          _total2 = _total;
        }
        _total = 0;
        _operador = simbolo;
        _punto = false;
      }
    });
  }

  void _realizaOperacion() {
    if (_operador == '+') {
      _total = _total2 + _total;
    } else if (_operador == '-') {
      _total = _total2 - _total;
    } else if (_operador == '*') {
      _total = _total2 * _total;
    } else if (_operador == '/') {
      if (_total != 0) {
        _total = _total2 / _total;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No se puede dividir por cero")),
        );
        _total = 0;
      }
    }
  }

  Widget _cargaTeclado(BuildContext context) {
    List<Widget> filas = [];
    for (var fila in _simboloTeclado) {
      List<Widget> botones = [];
      for (var tecla in fila) {
        botones.add(
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: MaterialButton(
              minWidth: 70,
              height: 70,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: Theme.of(context).colorScheme.inversePrimary,
              onPressed: () {
                if (tecla is int) {
                  _presionaNumero(tecla);
                } else if (tecla is String) {
                  _presionaSimbolo(tecla);
                }
              },
              child: Text(
                "$tecla",
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
        );
      }
      filas.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: botones,
      ));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: filas,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${_total.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),
          _cargaTeclado(context),
        ],
      ),
    );
  }
}
