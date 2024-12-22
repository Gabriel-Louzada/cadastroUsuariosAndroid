import 'package:flutter/material.dart';
import 'package:teste_bd/dao/UsuarioDao.dart';
import 'package:teste_bd/model/UsuarioModel.dart';
import 'package:teste_bd/screen/alterarCadastro.dart';

class UsuarioCar extends StatelessWidget {
  final UsuarioModel usuario;
  final Usuariodao usuariodao;
  final VoidCallback onUsuarioRemovido;

  const UsuarioCar(
      {required this.usuariodao,
      required this.usuario,
      required this.onUsuarioRemovido,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.account_circle,
        size: 50,
      ),
      title: Text(
        usuario.nome,
        style: const TextStyle(fontSize: 24),
      ),
      subtitle: Text(
        "Idade: ${usuario.idade}  E-mail: ${usuario.email}",
        style: const TextStyle(fontSize: 20),
      ),
      //PRESSIONAR E SEGURAR PARA REMOVER OS USUARIOS
      onLongPress: () async {
        //REMOVER USUARIO
        await usuariodao.removerUsuario(usuario.id!);

        //METODO PARA AUTALIZAÇÃO PARA REGARREGAR A LISTA DE USUARIOS
        onUsuarioRemovido();
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (contextNew) =>
                AlterarCadastro(usuario: usuario, usuarioContext: contextNew),
          ),
        );
      },
    );
  }
}
