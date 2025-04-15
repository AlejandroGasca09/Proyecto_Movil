import 'package:flutter/material.dart';
import 'package:proyecto_movil/pantallas/bienv.dart';
import 'package:proyecto_movil/pantallas/calendario.dart';
import 'package:proyecto_movil/pantallas/pantalla2.dart';
import 'package:proyecto_movil/pantallas/principal.dart';
import 'package:proyecto_movil/pantallas/localizacion.dart';
import 'pantallas/calc.dart';
import 'pantallas/tarjetas.dart';

class Navegador extends StatefulWidget{
  const Navegador({super.key});
  @override
  State<Navegador> createState() => _NavegadorState();

}
class _NavegadorState extends State<Navegador>{
  // Widget _cuerpo = Otra(title: "Hola a todos!!!!");
  Widget? _cuerpo;
  List<Widget> _pantallas = [];
  int _p=0;

  void _cambiaPantalla(int v) {
      setState(() {
        _p = v;
        _cuerpo = _pantallas[_p];
      });
  }

  @override
  void initState(){
    super.initState();
    _pantallas.add(const MyHomePage(title: "Hola"));
    _pantallas.add(const Otra(title: "Adios"));
    _pantallas.add(const Calculadora(title: "Calculadora"));
    _pantallas.add(const Localizacion(title: "Localizacion"));
    _pantallas.add(const Bienvenido(title: "Bienvenido"));
    _pantallas.add(const Calendario(title: "Calendario"));
    // _pantallas.add(const Tarjetas(nombres: nombres, descripciones: descripciones, rutas: rutas));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: _cuerpo,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _p,
          onTap: (value) { _cambiaPantalla(value);
          },
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(label:"Inicio",icon: Icon(Icons.home,)),
            BottomNavigationBarItem(label:"Imagen",icon: Icon(Icons.image,)),
            BottomNavigationBarItem(label:"Calculadora",icon: Icon(Icons.calculate,)),
            BottomNavigationBarItem(label:"Localizacion",icon: Icon(Icons.map,)),
            BottomNavigationBarItem(label:"Bienvenido",icon: Icon(Icons.drive_file_rename_outline,)),
            BottomNavigationBarItem(label:"Tarjetas",icon: Icon(Icons.credit_card,)),
          ]),
    );
  }
}
