import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Product {
  final String name;
  final double price;
  final String description;

  Product({
    required this.name,
    required this.price,
    required this.description,
  });
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aula 06 - Navegação e Rotas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/add-product': (context) => const AddProductScreen(),
        '/details': (context) => const ProductDetailScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Product> _products = [
    Product(
      name: 'Notebook',
      price: 3500.00,
      description: 'Notebook 15 polegadas, 16GB RAM.',
    ),
    Product(
      name: 'Mouse sem fio',
      price: 89.90,
      description: 'Mouse ergonômico sem fio.',
    ),
  ];

  Future<void> _abrirCadastro() async {
    final novoProduto = await Navigator.pushNamed(
      context,
      '/add-product',
    ) as Product?;

    if (novoProduto != null) {
      setState(() {
        _products.add(novoProduto);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Produto "${novoProduto.name}" adicionado!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
      ),
      body: _products.isEmpty
          ? const Center(child: Text('Nenhum produto cadastrado.'))
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final produto = _products[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.shopping_bag)),
                    title: Text(produto.name),
                    subtitle: Text(
                        'R\$ ${produto.price.toStringAsFixed(2)}'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/details',
                        arguments: produto,
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _abrirCadastro,
        icon: const Icon(Icons.add),
        label: const Text('Adicionar Produto'),
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  Future<bool> _confirmarSaida(BuildContext context) async {
    final resposta = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sair da tela'),
        content: const Text('Tem certeza que deseja voltar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Sair'),
          ),
        ],
      ),
    );
    return resposta ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final produto = ModalRoute.of(context)!.settings.arguments as Product;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final podeSair = await _confirmarSaida(context);
        if (podeSair && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(produto.name),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              final podeSair = await _confirmarSaida(context);
              if (podeSair && context.mounted) {
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                produto.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'R\$ ${produto.price.toStringAsFixed(2)}',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.indigo),
              ),
              const SizedBox(height: 16),
              Text(produto.description),
            ],
          ),
        ),
      ),
    );
  }
}

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _salvarProduto() {
    if (_formKey.currentState!.validate()) {
      final novoProduto = Product(
        name: _nameController.text.trim(),
        price: double.parse(_priceController.text.replaceAll(',', '.')),
        description: _descriptionController.text.trim(),
      );

      Navigator.pop(context, novoProduto);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome do produto',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o nome do produto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Preço (R\$)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o preço';
                  }
                  final normalizado = value.replaceAll(',', '.');
                  if (double.tryParse(normalizado) == null) {
                    return 'Informe um preço válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe uma descrição';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _salvarProduto,
                icon: const Icon(Icons.save),
                label: const Text('Salvar Produto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
