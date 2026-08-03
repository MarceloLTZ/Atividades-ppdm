import 'package:flutter/material.dart';

class Produto {
  final String titulo;
  final String descricao;
  final IconData icone;

  const Produto({
    required this.titulo,
    required this.descricao,
    required this.icone,
  });
}

class CatalogoDinamicoScreen extends StatelessWidget {
  const CatalogoDinamicoScreen({super.key});

  static final List<Produto> _produtos = [
    const Produto(
      titulo: 'Notebook Gamer X1',
      descricao: 'Processador Ryzen 7, 16GB RAM, placa de vídeo dedicada.',
      icone: Icons.laptop_mac,
    ),
    const Produto(
      titulo: 'Smartphone Nova Z',
      descricao: 'Tela AMOLED 6.5", câmera tripla e bateria de longa duração.',
      icone: Icons.smartphone,
    ),
    const Produto(
      titulo: 'Fone Bluetooth Air',
      descricao: 'Cancelamento de ruído ativo e até 30h de bateria.',
      icone: Icons.headphones,
    ),
    const Produto(
      titulo: 'Smartwatch Fit Pro',
      descricao: 'Monitoramento cardíaco, GPS integrado e resistência à água.',
      icone: Icons.watch,
    ),
    const Produto(
      titulo: 'Teclado Mecânico RGB',
      descricao: 'Switches azuis, iluminação RGB customizável.',
      icone: Icons.keyboard,
    ),
    const Produto(
      titulo: 'Monitor UltraWide 29"',
      descricao: 'Resolução Full HD, ideal para produtividade e jogos.',
      icone: Icons.desktop_windows,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo Dinâmico'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _produtos.length,
        itemBuilder: (context, index) {
          final produto = _produtos[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.indigo.shade50,
                child: Icon(produto.icone, color: Colors.indigo),
              ),
              title: Text(
                produto.titulo,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                produto.descricao,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Você tocou em ${produto.titulo}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}