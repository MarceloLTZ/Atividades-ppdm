import 'package:flutter/material.dart';
import 'perfil_dev.dart';
import 'catalogo_dinamico.dart';
import 'formulario_interativo.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Exercícios PPDM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const MenuPrincipal(),
    );
  }
}

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercícios - Módulos 01 e 02'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _botaoMenu(
            context,
            titulo: 'Exercício 1 - Cartão de Perfil Dev',
            icone: Icons.person,
            destino: const PerfilDevScreen(),
          ),
          const SizedBox(height: 12),
          _botaoMenu(
            context,
            titulo: 'Exercício 2 - Catálogo Dinâmico',
            icone: Icons.list_alt,
            destino: const CatalogoDinamicoScreen(),
          ),
          const SizedBox(height: 12),
          _botaoMenu(
            context,
            titulo: 'Exercício 3 - Formulário Interativo',
            icone: Icons.edit_note,
            destino: const FormularioInterativoScreen(),
          ),
        ],
      ),
    );
  }

  Widget _botaoMenu(
    BuildContext context, {
    required String titulo,
    required IconData icone,
    required Widget destino,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.centerLeft,
      ),
      icon: Icon(icone),
      label: Text(titulo),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => destino),
        );
      },
    );
  }
}