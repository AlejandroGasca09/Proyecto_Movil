import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key, required this.title});
  final String title;

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  double _total = 0 ;
  double _total2 = 0 ;
  int _contadorP = 10;
  bool _punto = false;
  void _presionaNumero(int n){
    setState(() {
      if(!_punto) _total = _total*10 + n;
      else {
        _total = _total+n/10;
        _contadorP*10;
      }
    });
  }
  void _presionaSimbolo(String a){
    if (a == "."){
      _punto = true;
    }
    if(a == '+'){
      _punto = false;
      _contadorP = 10;
      setState(() {
        _total2 += _total;
        _total=0;
      });
    }
    if(a == '='){
      setState(() {
        _total2 += _total;
        _total=0;
      });
    }
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
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    style: ButtonStyle(

                    ),
                    onPressed:(){_presionaNumero(9);},
                    child: Text("9"),
                  ),

                  OutlinedButton(
                    style: ButtonStyle(

                    ),
                    onPressed:(){_presionaNumero(9);},
                    child: Text("8"),
                  ),

                  OutlinedButton(
                    style: ButtonStyle(

                    ),
                    onPressed:(){_presionaNumero(9);},
                    child: Text("7"),
                  ),

                ]

            )
          ],

        ),
      ),
      floatingActionButton: Row(

      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}