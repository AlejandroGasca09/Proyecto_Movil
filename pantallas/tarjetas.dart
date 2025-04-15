import 'package:flutter/material.dart';


class Tarjetas extends StatefulWidget {
  Tarjetas(
      {
        super.key,
        required this.nombres,
        required this.descripciones,
        required this.rutas,
      });

  late List<String> nombres;
  late List<String> descripciones;
  late List<String> rutas;
  late double alto;
  late double ancho;

  @override
  State<Tarjetas> createState() => _TarjetasState();
}

class _TarjetasState extends State<Tarjetas> {
  List<Widget> _tarjetas = [];
  void _cargaTarjetas() {
    if (widget.nombres.isEmpty) {
      print("Error tarjetas: No se enviaron datos a nombres");
    } else if (widget.nombres.length == widget.descripciones.length &&
        widget.nombres.length == widget.rutas.length) {
      for (int i = 0; i < widget.nombres.length; i++) {
        _tarjetas.add(
          SizedBox(
            height: widget.alto,
            width: widget.ancho,
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: widget.alto - 20,
                    child: Image.asset(widget.rutas[i]),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.nombres[i]),
                      Text(widget.descripciones[i]),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
    } else {
      print(
          "Error tarjetas: Los elementos no son del mismo tamaño entre nombres, descripciones y rutas");
    }
    setState(() {}); // Refresca la UI después de cargar las tarjetas
  }

  @override
  void initState() {
    super.initState();
    _cargaTarjetas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Tarjetas"),
      ),
      body: Center(
        child: ListView(
          children: _tarjetas,
        ),
      ),
    );
  }
}