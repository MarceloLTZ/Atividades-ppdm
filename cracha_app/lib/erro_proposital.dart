// EXERCÍCIO 04 — ERRO PROPOSITAL
//
// Este arquivo demonstra o erro que ocorre ao trocar a propriedade
// 'child' do Container por 'children' (que não existe nessa classe).
//
// Trecho ORIGINAL (correto):
//
//   Container(
//     child: Column(
//       children: [ ... ],
//     ),
//   )
//
// Trecho COM ERRO PROPOSITAL (não compila):
//
//   Container(
//     children: [        // <-- ERRO: Container não possui 'children'
//       CircleAvatar(...),
//       Row(...),
//       Row(...),
//     ],
//   )
//
// MENSAGEM DE ERRO EMITIDA PELO ANALISADOR DART/FLUTTER:
//
//   error: No named parameter with the name 'children'. (undefined_named_parameter)
//    lib/exemplos/erro_proposital.dart:XX:5
//    Try correcting the name to an existing named parameter's name, or
//    defining a named parameter with the name 'children'.
//
// No terminal (flutter run / flutter analyze) a mensagem completa costuma
// aparecer assim:
//
//   lib/exemplos/erro_proposital.dart:XX:5: Error: No named parameter with
//   the name 'children'.
//       children: [
//       ^^^^^^^^
//
// EXPLICAÇÃO:
// O widget Container espera um único widget filho na propriedade 'child'
// (assim como Padding, Center, Align, etc — widgets de "single child").
// Já 'children' (uma List<Widget>) só existe em widgets de múltiplos
// filhos, como Column, Row, Stack, ListView, Wrap, etc.
// Por isso o analisador estático do Dart rejeita a compilação antes
// mesmo de rodar o app, indicando que o parâmetro nomeado 'children'
// não existe na assinatura do construtor de Container.
//
// CORREÇÃO: usar 'child' passando diretamente a Column (que aí sim
// recebe a lista em 'children'), como já é feito em
// lib/widgets/cartao_estudante.dart.
 
import 'package:flutter/material.dart';
 
class ContainerComErro extends StatelessWidget {
  const ContainerComErro({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      // Descomente a linha abaixo para reproduzir o erro descrito acima:
      // children: const [
      //   Icon(Icons.error),
      //   Text('Isto não compila'),
      // ],
 
      // Versão correta:
      child: Column(
        children: const [
          Icon(Icons.error),
          Text('Isto compila normalmente'),
        ],
      ),
    );
  }
}
 
