import 'package:flutter/material.dart';
import 'widgets/cartao_estudante.dart'; // Exercício 07: importação do widget extraído
 
void main() => runApp(const MyApp());
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crachá Estudantil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green, // cor principal dos ícones/tema em verde
      ),
      home: const CrachaScreen(),
    );
  }
}
 
class CrachaScreen extends StatelessWidget {
  const CrachaScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crachá do Estudante'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: CartaoEstudante(
          nome: 'João da Silva',
          email: 'joao.silva@estudante.edu.br',
          imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
        ),
      ),
    );
  }
}
 
