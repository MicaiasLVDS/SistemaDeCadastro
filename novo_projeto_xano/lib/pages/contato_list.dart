import 'package:flutter/material.dart';
import 'package:novo_projeto_xano/Models/contato_model.dart';
import 'package:novo_projeto_xano/Services/contato_service.dart';

class ContatoList extends StatefulWidget {
  const ContatoList({super.key});

  @override
  State<ContatoList> createState() => _ContatoListState();
}

class _ContatoListState extends State<ContatoList> {
  final servico = ContatoService();
  
  bool carregando = false;
  List<Contato> contatos = [];
  @override
  void initState() {
    super.initState();
    carregarContatos();
  }

  Future<void> carregarContatos() async {
    setState(() {
      carregando = true;
    });

    try {
      final lista = await servico.listar();
      setState(() {
        contatos = lista;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao carregar contatos: $e')));
    } finally {
      setState(() {
        carregando = false;
      });
    }
  }

Future<void> deletarContato(int id)async{
final resultado = await servico.deletar(id);

if (resultado){
await carregarContatos();  
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deletado com sucesso')));
}
else{
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao deletar')));
}
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Lista de Contatos'))),
      body: carregando
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    color: Colors.grey.shade300,
                    child: Row(
                      children: [
                        Icon(Icons.contact_page_rounded),
                        Expanded(
                          child: Text(
                            'Id',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Icon(Icons.person),
                        Expanded(
                          child: Text(
                            'Nome',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Icon(Icons.phone),
                        Expanded(
                          child: Text(
                            'Telefone',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Icon(Icons.email),
                        Expanded(
                          child: Text(
                            'Email',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: contatos.length,
                      itemBuilder: (context, index) {
                        final contato = contatos[index];
                        return Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(child: Text(contato.id.toString())),
                              Expanded(child: Text(contato.nome)),
                              Expanded(child: Text(contato.telefone)),
                              Expanded(child: Text(contato.email)),
                              Spacer(),
                              IconButton(onPressed: ()=>deletarContato(contato.id), icon: Icon(Icons.delete)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final resultado = await Navigator.pushNamed(context, '/novo');
          if (resultado == true) {
            carregarContatos();
          }
          Navigator.pushNamed(context, '/novo');
        },
      ),
    );
  }
}
