import 'package:flutter/material.dart';

class Calendario extends StatefulWidget {
  const Calendario({super.key, required this.title});

  final String title;

  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'maaaaas o meeeeeenos bienvenido',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text(
              'ESTE ES UN NUEVO COMENTARIO',
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10), // Espacio entre los botones
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 10), // Espacio entre los botones
          FloatingActionButton(
            onPressed: () {
              // Ejemplo de funcionalidad específica (puedes personalizarla)
              print('Botón de Apple presionado');
            },
            tooltip: 'Apple',
            child: const Icon(Icons.apple_outlined),
          ),
          const SizedBox(width: 10), // Espacio entre los botones
          FloatingActionButton(
            onPressed: () {
              // Ejemplo de funcionalidad específica (puedes personalizarla)
              print('Botón de Android presionado');
            },
            tooltip: 'Android',
            child: const Icon(Icons.android_rounded),
          ),
        ],
      ),
    );
  }
}