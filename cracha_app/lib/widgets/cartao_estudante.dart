import 'package:flutter/material.dart';
 
/// Widget customizado que representa o crachá de um estudante.
///
/// Extraído do main.dart no Exercício 07 para permitir reutilização
/// (ver Exercício 08, onde vários cartões são exibidos em lista).
class CartaoEstudante extends StatelessWidget {
  final String nome;
  final String email;
  final String status;
  final String imageUrl;
 
  const CartaoEstudante({
    super.key,
    required this.nome,
    required this.email,
    this.status = 'Status: Matriculado / Ativo',
    required this.imageUrl,
  });
 
  @override
  Widget build(BuildContext context) {
    // Exercício 01: fundo em tonalidade leve de verde
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      // Exercício 05: Padding extra de 8px em todos os lados envolvendo a Column
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Exercício 03: foto de perfil real via NetworkImage
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.green.shade100,
              foregroundImage: NetworkImage(imageUrl),
              child: const Icon(Icons.person, color: Colors.green),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.badge, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  nome,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.email, color: Colors.green),
                const SizedBox(width: 8),
                Text(email),
              ],
            ),
            const SizedBox(height: 8),
            // Exercício 02: linha com situação da matrícula
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 8),
                Text(status),
              ],
            ),
            const SizedBox(height: 16),
            // Exercício 06: rodapé com botão de validação
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Validar Carteirinha'),
            ),
          ],
        ),
      ),
    );
  }
}
