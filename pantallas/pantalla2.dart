import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Otra extends StatefulWidget {
  const Otra({super.key, required this.title});
  final String title;

  @override
  State<Otra> createState() => _OtraState();
}

class _OtraState extends State<Otra> {

  String _nombre = "";
  int _counter = 0;
  SharedPreferences? _prefs;

  void _cargarPreferencias() async{
    _prefs = await SharedPreferences.getInstance();
    _cargaNombre();
  }

  void _cargaNombre() async{
    String? nombre = await _prefs?.getString("Nombre");
    if(nombre != null){
      setState(() {
        _nombre =  nombre;
      });
    }
  }

  @override
  void initState() {
     super.initState();
     _cargaNombre();
  }

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
              'Bienvenido',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            SizedBox(
              height: _counter.toDouble(),
              child: Image.network(
                  "https://uploads-ssl.webflow.com/6377bf360873283fad488724/638ca82a95fb434e6f42a283_Flutter.png"),
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
