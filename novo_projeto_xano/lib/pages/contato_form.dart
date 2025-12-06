import 'package:flutter/material.dart';
import 'package:novo_projeto_xano/Models/contato_model.dart';
import 'package:novo_projeto_xano/Services/contato_service.dart';

class ContatoForm extends StatefulWidget {
  const ContatoForm({super.key});

  @override
  State<ContatoForm> createState() => _ContatoFormState();
}

class _ContatoFormState extends State<ContatoForm> {
  final nomeControler = TextEditingController();
  final telefoneControler = TextEditingController();
  final emailControler = TextEditingController();
  final ContatoService servico = ContatoService();
  bool carregando = false;

  Future<void> salvarContato() async {
    setState(() {
      carregando = true;
    });

    final contato = Contato(
      id: 0,
      nome: nomeControler.text,
      telefone: telefoneControler.text,
      email: emailControler.text,
    );
    final resultado = await servico.adicionar(contato);
    setState(() {
      carregando = false;
    });

    if (resultado != null) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Contato Salvo')));
    } else {
      if (!mounted) return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Erro ao Salvar')));
  }
@override
  void dispose() {
    nomeControler.dispose();
    emailControler.dispose();
    telefoneControler.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Scaffold(
        appBar: AppBar(title: Text('Cadastar Novo Usuario')),
        body: Form(
          child: Column(
            children: [
              TextFormField(
                controller: nomeControler,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextFormField(
                controller: telefoneControler,
                decoration: InputDecoration(labelText: 'Telefone'),
              ),
              TextFormField(
                controller: emailControler,
                decoration: InputDecoration(labelText: 'E-mail'),
              ),
              SizedBox(height: 16),
              carregando
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: salvarContato,
                      child: Text('Salvar'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
