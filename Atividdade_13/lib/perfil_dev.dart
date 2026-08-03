import 'package:flutter/material.dart';

class PerfilDevScreen extends StatelessWidget {
  const PerfilDevScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil Dev'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.indigo,
              child: Icon(
                Icons.person,
                size: 70,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Marcelo Barbosa Wenceslau Filho',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Técnico em Desenvolvimento de Sistemas',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 12),
            _infoRow(icone: Icons.schedule, texto: 'Turno: Manhã e Tarde'),
            _infoRow(icone: Icons.groups, texto: 'Turma: T2DEV-T3'),
            _infoRow(
              icone: Icons.email,
              texto: 'marcelo.w@gmail.com',
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow({required IconData icone, required String texto}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icone, color: Colors.indigo, size: 22),
          const SizedBox(width: 10),
          Text(
            texto,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}