import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_bd/model/UsuarioModel.dart';
import 'package:teste_bd/provider/provider.dart';

class CadastrarUsuario extends StatefulWidget {
  const CadastrarUsuario({super.key, required this.usuarioContext});

  final BuildContext usuarioContext;

  @override
  State<CadastrarUsuario> createState() => _CadastrarUsuarioState();
}

class _CadastrarUsuarioState extends State<CadastrarUsuario> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool validar(String? valor) {
    if (valor != null && valor.isNotEmpty) {
      return false;
    } else {
      return true;
    }
  }

// Certifique-se de descartar o controlador para evitar vazamentos de memória
  @override
  void dispose() {
    _nomeController.dispose();
    _idadeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cadastrar Usuario",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              const Text("Cadastrando Usuario ",
                  style: TextStyle(fontSize: 40)),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller:
                    _nomeController, //Armazena o valor digitado no form nessa variavel
                validator: (String? value) {
                  if (validar(value)) {
                    return "Insira o nome do usuario";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: "Nome:",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _idadeController,
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (validar(value)) {
                    return "Insira a idade do usuario";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: "Idade:",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (String? value) {
                  if (validar(value)) {
                    return "Insira o E-mail do usuario";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: "E-mail:",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    //pegando os valores do textField e aplicando uma formatação tirando espaços em branco
                    final nome = _nomeController.text.trim();
                    final idade = _idadeController.text.trim();
                    final email = _emailController.text.trim();

                    final UsuarioModel usuario = UsuarioModel(
                        nome: nome, idade: int.parse(idade), email: email);

                    // Usando o Provider para acessar a instância existente
                    await Provider.of<UsuarioProvider>(context, listen: false)
                        .adicionarUsuario(usuario);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Cadastrando usuario"),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Cadastrar",
                  style: TextStyle(
                    fontSize: 20,
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
