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
  String _nombreGuardado = "";

  Future<SharedPreferences> _obtenerPreferencias() async {
    return SharedPreferences.getInstance();
  }

  void _guardaNombre(String nom) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("nombre", nom);
    setState(() {
      _nombreGuardado = nom; // Actualizamos el nombre guardado
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Nombre guardado: $nom")),
    );
  }

  void _cargaNombre() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nombreGuardado = prefs.getString("nombre") ?? "No hay nombre guardado";
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
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _nombre,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Escribe tu nombre",
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_nombre.text.isNotEmpty) {
                  _guardaNombre(_nombre.text);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Por favor, ingresa un nombre")),
                  );
                }
              },
              child: const Text("Guardar Nombre"),
            ),
            const SizedBox(height: 20),
            Text(
              "Nombre guardado: $_nombreGuardado",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}