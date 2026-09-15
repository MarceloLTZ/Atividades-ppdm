import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/produto.dart';
import 'providers/carrinho_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CarrinhoProvider(),
      child: const CarrinhoApp(),
    ),
  );
}

class CarrinhoApp extends StatelessWidget {
  const CarrinhoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carrinho com Provider',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: CatalogoScreen(),
    );
  }
}

class CatalogoScreen extends StatelessWidget {
  CatalogoScreen({super.key});

  final List<Produto> _produtos = [
    Produto(id: '1', nome: 'Teclado Mecânico', preco: 250.00),
    Produto(id: '2', nome: 'Mouse Gamer', preco: 120.00),
    Produto(id: '3', nome: 'Monitor 24"', preco: 890.00),
    Produto(id: '4', nome: 'Headset Stereo', preco: 180.00),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Produtos'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CarrinhoScreen()),
                  );
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Consumer<CarrinhoProvider>(
                  builder: (context, carrinho, child) {
                    return carrinho.quantidade == 0
                        ? const SizedBox()
                        : CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Text(
                              '${carrinho.quantidade}',
                              style: const TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          );
                  },
                ),
              )
            ],
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _produtos.length,
        itemBuilder: (context, index) {
          final prod = _produtos[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(prod.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('R\$ ${prod.preco.toStringAsFixed(2)}'),
              trailing: Consumer<CarrinhoProvider>(
                builder: (context, carrinho, child) {
                  final estaNoCarrinho = carrinho.itens.any((item) => item.id == prod.id);

                  return IconButton(
                    icon: Icon(
                      estaNoCarrinho ? Icons.check_circle : Icons.add_shopping_cart,
                      color: estaNoCarrinho ? Colors.green : Colors.teal,
                    ),
                    onPressed: () {
                      carrinho.adicionar(prod);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${prod.nome} adicionado ao carrinho!'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class CarrinhoScreen extends StatefulWidget {
  const CarrinhoScreen({super.key});

  @override
  State<CarrinhoScreen> createState() => _CarrinhoScreenState();
}

class _CarrinhoScreenState extends State<CarrinhoScreen> {
  final TextEditingController _cupomController = TextEditingController();

  void _confirmarAcao(BuildContext context, CarrinhoProvider carrinho, {required bool finalizar}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(finalizar ? 'Finalizar Compra' : 'Esvaziar Carrinho'),
        content: Text(
          finalizar
              ? 'Deseja confirmar a compra no valor total de R\$ ${carrinho.valorTotal.toStringAsFixed(2)}?'
              : 'Tem certeza de que deseja remover todos os itens do carrinho?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              carrinho.limpar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    finalizar ? 'Compra finalizada com sucesso!' : 'Carrinho esvaziado!',
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: finalizar ? Colors.teal : Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cupomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seu Carrinho'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          Consumer<CarrinhoProvider>(
            builder: (context, carrinho, child) {
              if (carrinho.quantidade == 0) return const SizedBox();
              return IconButton(
                icon: const Icon(Icons.delete_sweep),
                onPressed: () => _confirmarAcao(context, carrinho, finalizar: false),
                tooltip: 'Esvaziar carrinho',
              );
            },
          )
        ],
      ),
      body: Consumer<CarrinhoProvider>(
        builder: (context, carrinho, child) {
          if (carrinho.quantidade == 0) {
            return const Center(
              child: Text(
                'Seu carrinho está vazio!',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: carrinho.itens.length,
                  itemBuilder: (context, index) {
                    final item = carrinho.itens[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: ListTile(
                        title: Text(item.nome),
                        subtitle: Text(
                          'R\$ ${item.preco.toStringAsFixed(2)} x ${item.quantidade} = R\$ ${(item.preco * item.quantidade).toStringAsFixed(2)}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                              onPressed: () => carrinho.decrementarQuantidade(item),
                            ),
                            Text(
                              '${item.quantidade}',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                              onPressed: () => carrinho.incrementarQuantidade(item),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.grey.shade100,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _cupomController,
                        decoration: const InputDecoration(
                          hintText: 'Cupom de desconto (ex: SENAI10)',
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        bool sucesso = carrinho.aplicarCupom(_cupomController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              sucesso
                                  ? 'Cupom SENAI10 aplicado! (10% de desconto)'
                                  : 'Cupom inválido. Tente "SENAI10".',
                            ),
                            backgroundColor: sucesso ? Colors.green : Colors.red,
                          ),
                        );
                      },
                      child: const Text('Aplicar'),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                color: Colors.teal.shade50,
                child: Column(
                  children: [
                    if (carrinho.temDesconto) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal:'),
                          Text('R\$ ${carrinho.valorSubtotal.toStringAsFixed(2)}'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Desconto (10%):', style: TextStyle(color: Colors.green)),
                          Text(
                            '- R\$ ${carrinho.valorDesconto.toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: R\$ ${carrinho.valorTotal.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          onPressed: () => _confirmarAcao(context, carrinho, finalizar: true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Finalizar'),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}