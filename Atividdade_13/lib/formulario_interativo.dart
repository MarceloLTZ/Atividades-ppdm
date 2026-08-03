import 'package:flutter/material.dart';

class FormularioInterativoScreen extends StatefulWidget {
  const FormularioInterativoScreen({super.key});

  @override
  State<FormularioInterativoScreen> createState() =>
      _FormularioInterativoScreenState();
}

class _FormularioInterativoScreenState
    extends State<FormularioInterativoScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cargoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? _nomeCadastrado;
  String? _cargoCadastrado;

  @override
  void dispose() {
    _nomeController.dispose();
    _cargoController.dispose();
    super.dispose();
  }

  void _cadastrar() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _nomeCadastrado = _nomeController.text;
        _cargoCadastrado = _cargoController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário Interativo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe seu nome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cargoController,
                decoration: const InputDecoration(
                  labelText: 'Profissão / Cargo desejado',
                  prefixIcon: Icon(Icons.work_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o cargo desejado';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _cadastrar,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Cadastrar'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              const SizedBox(height: 24),

              if (_nomeCadastrado != null && _cargoCadastrado != null)
                Card(
                  color: Colors.indigo.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.celebration, color: Colors.indigo),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Bem-vindo(a), $_nomeCadastrado! '
                            'Cargo cadastrado: $_cargoCadastrado',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}