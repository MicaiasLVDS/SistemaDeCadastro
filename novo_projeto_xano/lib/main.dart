import 'package:flutter/material.dart';
import 'package:novo_projeto_xano/pages/contato_form.dart';
import 'package:novo_projeto_xano/pages/contato_list.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {'/': (context) => ContatoList(),
       '/novo': (context) => ContatoForm(),
      },
    );
  }
}
