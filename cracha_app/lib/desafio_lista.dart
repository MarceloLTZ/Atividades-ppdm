import 'package:flutter/material.dart';
import 'widgets/cartao_estudante.dart';
 
/// EXERCÍCIO 08
/// Tela que exibe uma Column com 3 crachás de estudantes diferentes,
/// um abaixo do outro, com espaçamento entre eles.
///
/// Para usar esta tela como ponto de entrada, troque o `home:` do
/// MaterialApp em main.dart para `const DesafioListaScreen()`,
/// ou rode este arquivo criando um main() próprio (exemplo abaixo).
class DesafioListaScreen extends StatelessWidget {
  const DesafioListaScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Crachás'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Column(
            children: const [
              CartaoEstudante(
                nome: 'João da Silva',
                email: 'joao.silva@estudante.edu.br',
                imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
              ),
              SizedBox(height: 24),
              CartaoEstudante(
                nome: 'Maria Oliveira',
                email: 'maria.oliveira@estudante.edu.br',
                status: 'Status: Matriculado / Ativo',
                imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
              ),
              SizedBox(height: 24),
              CartaoEstudante(
                nome: 'Carlos Pereira',
                email: 'carlos.pereira@estudante.edu.br',
                status: 'Status: Trancado',
                imageUrl: 'https://randomuser.me/api/portraits/men/65.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 
// Ponto de entrada opcional para rodar este arquivo isoladamente:
// void main() => runApp(const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: DesafioListaScreen(),
//     ));
 
