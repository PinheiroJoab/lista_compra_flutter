import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class Produtos {
  String nome;

  Produtos(this.nome);
}


final List<Produtos> listaCompras = [
  Produtos("Arroz"),
  Produtos("Feijão"),
  Produtos("Carne"),
  Produtos("Filé de frango"),
  Produtos("Macarrão"),
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

    void apagarItem(int index) {
    setState(() {
      listaCompras.removeAt(index);
    });
  }
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

                  if (index%2==0){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Color.fromARGB(255, 161, 240, 165),
                        child: ListTile(
                          title: Text("Comprar ${listaCompras[index].nome}"),
                         // subtitle: Text("Quantidade $quantidade"),
                          leading: Icon(Icons.shopping_cart, color: Colors.white),
                          trailing: Icon(Icons.arrow_forward, color: Colors.white),
                         onLongPress: () => apagarItem(index),
                        ),
                      ),
                    );
                  }
                  else{
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                       color: Color.fromARGB(255, 6, 61, 8),
                      child: ListTile(
                        title: Text("Comprar ${listaCompras[index].nome}", style: TextStyle(color: Colors.white),),
                       // subtitle: Text("Quantidade $quantidade"),
                        leading: Icon(Icons.shopping_cart),
                        trailing: Icon(Icons.arrow_forward),
                       onLongPress: () => apagarItem(index),
                      ),
                    ),
                  );}
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
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onSubmitted: (value, ) {
                    listaCompras.add(Produtos(value));
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            /*Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onSubmitted: (value) {
                   quantidade = value;
                    
                    Navigator.pop(context);
                    
                  },
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}