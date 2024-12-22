import 'package:flutter/material.dart';
import 'package:teste_bd/dao/UsuarioDao.dart';
import 'package:teste_bd/model/UsuarioModel.dart';
import 'package:teste_bd/screen/cadastro.dart';
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
    carregarUsuarios();
  }

  void carregarUsuarios() async {
    final lista = await usuariodao.listarTodosUsuarios();
    setState(() {
      usuarios = lista;
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
        actions: [
          IconButton(
              onPressed: () {
                carregarUsuarios();
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ))
        ],
        backgroundColor: Colors.blueAccent,
      ),
      body: usuarios.isEmpty
          ? const Center(
              child: Text("Nenhum usuarios encontrado!"),
            )
          : ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, index) {
                final usuario = usuarios[index];
                return UsuarioCar(
                  usuario: usuario,
                  usuariodao: usuariodao,
                  onUsuarioRemovido: carregarUsuarios,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) =>
                  CadatroUsuario(usuarioContext: contextNew),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
