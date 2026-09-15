import 'package:flutter/foundation.dart';
import '../models/produto.dart';

class CarrinhoProvider extends ChangeNotifier {
  final List<Produto> _itens = [];
  double _porcentagemDesconto = 0.0;

  List<Produto> get itens => List.unmodifiable(_itens);

  int get quantidade => _itens.fold(0, (total, item) => total + item.quantidade);

  double get valorSubtotal {
    return _itens.fold(0.0, (total, item) => total + (item.preco * item.quantidade));
  }

  double get valorDesconto => valorSubtotal * _porcentagemDesconto;

  double get valorTotal => valorSubtotal - valorDesconto;

  bool get temDesconto => _porcentagemDesconto > 0;

  void adicionar(Produto produto) {
    final index = _itens.indexWhere((item) => item.id == produto.id);
    if (index >= 0) {
      _itens[index].quantidade++;
    } else {
      _itens.add(
        Produto(
          id: produto.id,
          nome: produto.nome,
          preco: produto.preco,
          quantidade: 1,
        ),
      );
    }
    notifyListeners();
  }

  void incrementarQuantidade(Produto produto) {
    produto.quantidade++;
    notifyListeners();
  }

  void decrementarQuantidade(Produto produto) {
    if (produto.quantidade > 1) {
      produto.quantidade--;
    } else {
      _itens.removeWhere((item) => item.id == produto.id);
    }
    notifyListeners();
  }

  void remover(Produto produto) {
    _itens.removeWhere((item) => item.id == produto.id);
    notifyListeners();
  }

  bool aplicarCupom(String cupom) {
    if (cupom.trim().toUpperCase() == 'SENAI10') {
      _porcentagemDesconto = 0.10;
      notifyListeners();
      return true;
    }
    return false;
  }

  void removerCupom() {
    _porcentagemDesconto = 0.0;
    notifyListeners();
  }

  void limpar() {
    _itens.clear();
    _porcentagemDesconto = 0.0;
    notifyListeners();
  }
}
