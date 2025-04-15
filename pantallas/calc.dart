import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key, required this.title});
  final String title;

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  double _valor1 = 0;
  double _valor2 = 0;
  String _operador = "";
  String _texto = "0"; // Para mostrar el resultado y los números presionados
  bool _punto = false; // Controla si se presionó el punto decimal
  int _contadorDecimal = 10; // Para manejar los decimales

  final List<List<dynamic>> _simboloTeclado = [
    [7, 8, 9, '/'],
    [4, 5, 6, '*'],
    [1, 2, 3, '-'],
    ['.', 0, '=', '+']
  ];

  void _presionaNumero(int n) {
    setState(() {
      if (_operador.isEmpty) {
        // Estamos ingresando el primer número
        if (!_punto) {
          _valor1 = _valor1 * 10 + n;
        } else {
          _valor1 = _valor1 + n / _contadorDecimal;
          _contadorDecimal *= 10;
        }
        _texto = _valor1.toStringAsFixed(2);
      } else {
        // Estamos ingresando el segundo número
        if (!_punto) {
          _valor2 = _valor2 * 10 + n;
        } else {
          _valor2 = _valor2 + n / _contadorDecimal;
          _contadorDecimal *= 10;
        }
        _texto = _valor2.toStringAsFixed(2);
      }
    });
  }

  void _presionaSimbolo(String simbolo) {
    setState(() {
      if (simbolo == ".") {
        if (!_punto) {
          _punto = true;
          _texto += ".";
        }
      } else if (simbolo == "=") {
        _realizaOperacion();
      } else {
        // Configurar el operador
        _operador = simbolo;
        _punto = false;
        _contadorDecimal = 10; // Reiniciar el contador decimal
      }
    });
  }

  void _realizaOperacion() {
    setState(() {
      double resultado = 0;
      if (_operador == "+") {
        resultado = _valor1 + _valor2;
      } else if (_operador == "-") {
        resultado = _valor1 - _valor2;
      } else if (_operador == "*") {
        resultado = _valor1 * _valor2;
      } else if (_operador == "/") {
        if (_valor2 != 0) {
          resultado = _valor1 / _valor2;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No se puede dividir por cero")),
          );
          return;
        }
      }

      // Actualizar los valores y el texto
      _valor1 = resultado;
      _valor2 = 0;
      _operador = "";
      _punto = false;
      _contadorDecimal = 10;
      _texto = resultado.toStringAsFixed(2);
    });
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              readOnly: true, // Hacerlo de solo lectura
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Resultado',
              ),
              controller: TextEditingController(text: _texto), // Mostrar el texto
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(height: 20),
          _cargaTeclado(context),
        ],
      ),
    );
  }
}