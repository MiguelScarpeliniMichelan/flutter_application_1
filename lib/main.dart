import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: FormularioExemplo()));

class FormularioExemplo extends StatefulWidget {
  const FormularioExemplo({super.key});

  @override
  State<FormularioExemplo> createState() => _FormularioExemploState();
}

class _FormularioExemploState extends State<FormularioExemplo> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _especieController = TextEditingController();
  final _idadeController = TextEditingController();
  final _nomeController = TextEditingController();
  bool _animalCastrado = false;

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    _especieController.dispose();
    _idadeController.dispose();
    _nomeController.dispose();
    super.dispose();
  }

  void _submeterFormulario() {
    if (_formKey.currentState?.validate() ?? false) {
      final nome = _nomeController.text.trim();
      final especie = _especieController.text;
      final idade = int.tryParse(_idadeController.text) ?? 0;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Animal cadastrado: $nome ($especie, $idade anos, castrado: $_animalCastrado)',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro Rápido')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              
              
              const SizedBox(height: 16),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do Animal',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if ((value ?? '').trim().isEmpty) {
                    return 'Informe o nome do animal!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _especieController.text.isNotEmpty ? _especieController.text : null,
                decoration: const InputDecoration(
                  labelText: 'Espécie',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Cachorro', child: Text('Cachorro')),
                  DropdownMenuItem(value: 'Gato', child: Text('Gato')),
                  DropdownMenuItem(value: 'Peixe', child: Text('Peixe')),
                ],
                onChanged: (value) {
                  setState(() {
                    _especieController.text = value ?? '';
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Selecione uma espécie!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _idadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Idade do Animal',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final idade = int.tryParse(value ?? '');
                  if (idade == null || idade < 0) {
                    return 'A idade deve ser um número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Seu animal é castrado?'),
                value: _animalCastrado,
                onChanged: (bool? value) {
                  setState(() {
                    _animalCastrado = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submeterFormulario,
                child: const Text('Cadastrar Animal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
