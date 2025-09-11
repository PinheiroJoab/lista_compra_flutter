
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'dart:convert';

void main() {
  runApp(const MainApp());
}
// Classe responsável por representar um produto na lista de compras
class Produtos {
  String nome;

  Produtos(this.nome);
}

// Lista global de produtos
final List<Produtos> listaCompras = [

];
  // Widget principal responsável pela construção do aplicativo
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

    // Widget de estado para a página da lista de compras
  class _ListPagState extends StatefulWidget {
  const _ListPagState();

  @override
  State<_ListPagState> createState() => __ListPagStateState();
}

// Mostra a lista de compras e permite adicionar novos itens
class __ListPagStateState extends State<_ListPagState> {

  @override
  void initState() {
    super.initState();
    carregarLista();
  }
  // Salva a lista de compras no armazenamento local
  Future<void> salvarLista() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> nomes = listaCompras.map((p) => p.nome).toList();
    await prefs.setStringList('listaCompras', nomes);
  }
// Carrega a lista de compras do armazenamento local
  Future<void> carregarLista() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? nomes = prefs.getStringList('listaCompras');
    if (nomes != null) {
      setState(() {
        listaCompras.clear();
        listaCompras.addAll(nomes.map((n) => Produtos(n)));
      });
    }
  }
// Apaga um item da lista de compras
  void apagarItem(int index) {
    setState(() {
      listaCompras.removeAt(index);
    });
    salvarLista();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) => EntradaPage(onAdd: (produto) {
                  setState(() {
                    listaCompras.add(Produtos(produto));
                  });
                  salvarLista();
                }),
              );
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
            SizedBox(height: 64),            
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
                          leading: Icon(Icons.shopping_cart, color: Colors.black),
                          trailing: Icon(Icons.arrow_forward, color: Colors.black),
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
                        leading: Icon(Icons.shopping_cart, color: Colors.white,),
                        trailing: Icon(Icons.arrow_forward, color: Colors.white,),
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
// Página de exemplo para adicionar um novo produto
class EntradaPage extends StatefulWidget {
  final void Function(String) onAdd;
  const EntradaPage({super.key, required this.onAdd});

  @override
  State<EntradaPage> createState() => _EntradaPageState();
}

class _EntradaPageState extends State<EntradaPage> {
  String produto = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Adicionar Produto"),
      content: TextField(
        onChanged: (value) {
          setState(() {
            produto = value;
          });
        },
        decoration: InputDecoration(hintText: "Nome do produto"),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancelar"),
        ),
        TextButton(
          onPressed: () {
            if (produto.isNotEmpty) {
              widget.onAdd(produto);
            }
            Navigator.of(context).pop();
          },
          child: Text("Adicionar"),
        ),
      ],
    );
  }
}

