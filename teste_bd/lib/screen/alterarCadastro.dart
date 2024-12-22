import 'package:flutter/material.dart';
import 'package:teste_bd/dao/UsuarioDao.dart';
import 'package:teste_bd/model/UsuarioModel.dart';

class AlterarCadastro extends StatefulWidget {
  const AlterarCadastro(
      {super.key, required this.usuario, required this.usuarioContext});

  final UsuarioModel usuario;
  final BuildContext usuarioContext;

  @override
  State<AlterarCadastro> createState() => _AlterarCadastroState();
}

class _AlterarCadastroState extends State<AlterarCadastro> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _idadeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool validar(String? valor) {
    if (valor != null && valor.isNotEmpty) {
      return false;
    } else {
      return true;
    }
  }

// Inicializa o TextEditingController com o nome atual
  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.usuario.nome);
    _idadeController =
        TextEditingController(text: widget.usuario.idade.toString());
    _emailController = TextEditingController(text: widget.usuario.email);
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
          "Alterar Cadastro",
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
              const Text("Alterando o cadastro ",
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
                    final id = widget.usuario.id;
                    final nome = _nomeController.text.trim();
                    final idade = _idadeController.text.trim();
                    final email = _emailController.text.trim();

                    final UsuarioModel usuario = UsuarioModel(
                        id: id,
                        nome: nome,
                        idade: int.parse(idade),
                        email: email);
                    // alterando o cadastro do usuario
                    await Usuariodao().alterarUsuario(usuario);

                    print(usuario);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Alterando o usuario"),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Alterar",
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
