class Produto {
  final String id;
  final String nome;
  final double preco;
  int quantidade;

  Produto({
    required this.id,
    required this.nome,
    required this.preco,
    this.quantidade = 1,
  });
}
