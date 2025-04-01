import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bienvenido extends StatefulWidget {
  const Bienvenido({super.key, required this.title});
  final String title;

  @override
  State<Bienvenido> createState() => _BienvenidoState();
}

class _BienvenidoState extends State<Bienvenido> {

  TextEditingController _nombre = TextEditingController();

  Future<SharedPreferences> _obtenerPreferencias() async {
    return SharedPreferences.getInstance();
  }

  void guardaNombre(String nom) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("nombre", nom);
  }
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter += 25;
    });
  }

  void _decrementCounter() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _counter -= 25;
      });
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
              'Ingresa tu nombre',
              style: TextStyle(
                fontSize: 80,
              ),
            ),
            SizedBox(
              width: 400,
              child: TextField(
                  textAlign: TextAlign.center,),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment:
        MainAxisAlignment.end, // Alinea los botones a la derecha
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10), // Espacio entre botones
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}