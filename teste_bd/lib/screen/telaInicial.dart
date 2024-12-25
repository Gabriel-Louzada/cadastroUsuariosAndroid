import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_bd/dao/UsuarioDao.dart';
import 'package:teste_bd/model/UsuarioModel.dart';
import 'package:teste_bd/provider/provider.dart';
import 'package:teste_bd/screen/telaCadastro.dart';
import 'package:teste_bd/widgets/usuarioCard.dart';

class Telainicial extends StatefulWidget {
  const Telainicial({super.key});

  @override
  State<Telainicial> createState() => _TelainicialState();
}

class _TelainicialState extends State<Telainicial> {
  final Usuariodao usuariodao = Usuariodao();
  List<UsuarioModel> usuarios = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Aguarda o contexto estar disponível antes de acessar o Provider
      Provider.of<UsuarioProvider>(context, listen: false).carregarUsuarios();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Exibindo usuarios",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Consumer<UsuarioProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.usuarios.length,
            itemBuilder: (context, index) {
              final usuarioprovider = provider.usuarios[index];
              return UsuarioCar(
                usuario: usuarioprovider,
                usuariodao: usuariodao,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) =>
                  CadastrarUsuario(usuarioContext: contextNew),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
