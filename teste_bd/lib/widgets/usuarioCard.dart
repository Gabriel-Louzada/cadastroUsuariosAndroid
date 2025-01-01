import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_bd/dao/UsuarioDao.dart';
import 'package:teste_bd/model/UsuarioModel.dart';
import 'package:teste_bd/provider/provider.dart';
import 'package:teste_bd/screen/alterarCadastro.dart';

class UsuarioCar extends StatelessWidget {
  final UsuarioModel usuario;
  final Usuariodao usuariodao;

  const UsuarioCar(
      {required this.usuariodao, required this.usuario, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: usuario.imagem == null
          ? const Icon(Icons.person)
          : CircleAvatar(
              backgroundImage: FileImage(File(usuario.imagem!)),
              radius: 25,
            ),
      title: Text(
        usuario.nome,
        style: const TextStyle(fontSize: 19),
      ),
      subtitle: Text(
        "Idade: ${usuario.idade}  E-mail: ${usuario.email}",
        style: const TextStyle(fontSize: 15),
      ),
      //PRESSIONAR PARA REMOVER OS USUARIOS
      onLongPress: () async {
        //REMOVER USUARIO
        await Provider.of<UsuarioProvider>(context, listen: false)
            .removerUsuario(usuario.id!);
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (contextNew) => AlterarCadastro(
              usuarioContext: contextNew,
              usuario: usuario,
            ),
          ),
        );
      },
    );
  }
}
