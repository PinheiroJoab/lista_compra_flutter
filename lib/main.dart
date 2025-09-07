import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class Lista {
  String nome;
  Lista(this.nome);
}

final List<Lista> listaCompras = [
  Lista("Arroz"),
  Lista("Feijão"),
  Lista("Carne"),
  Lista("Filé de frango"),
  Lista("Macarrão"),
];

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 12, 97, 15),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: _ListPagState()
    );
  }

}
  class _ListPagState extends StatefulWidget {
  const _ListPagState({super.key});

  @override
  State<_ListPagState> createState() => __ListPagStateState();
}

// Mostra a lista de compras e permite adicionar novos itens
class __ListPagStateState extends State<_ListPagState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExemploPage()),
              );
              setState(() {}); // Atualiza a lista ao voltar
            },
            child: Icon(Icons.add),
          ),
        ),
        appBar: AppBar(
          title: Text(
            "Lista de compras",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: listaCompras.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Lista de compras ${listaCompras[index].nome}"),
                    subtitle: Text("Subtítulo $index"),
                    leading: Icon(Icons.shopping_cart),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                     /* Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ExemploPage()),
                      );*/
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
  }
}

class ExemploPage extends StatelessWidget {
  const ExemploPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('informe o produto que falta')),
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onSubmitted: (value) {
                listaCompras.add(Lista(value));
                
                Navigator.pop(context);
                
              },
            ),
          ),
        ),
      ),
    );
  }
}