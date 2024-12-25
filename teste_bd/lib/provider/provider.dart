import 'package:flutter/foundation.dart';
import 'package:teste_bd/dao/UsuarioDao.dart';
import 'package:teste_bd/model/UsuarioModel.dart';

class UsuarioProvider extends ChangeNotifier {
  List<UsuarioModel> _usuarios = [];

  List<UsuarioModel> get usuarios => _usuarios;

  //CARREGAR TODOS OS USUARIOS
  Future<void> carregarUsuarios() async {
    _usuarios = await Usuariodao().listarTodosUsuarios();
    notifyListeners();
  }

  //ADICIONAR UM PRODUTO
  Future<void> adicionarUsuario(UsuarioModel usuario) async {
    await Usuariodao().inserirUsuario(usuario);
    carregarUsuarios();
  }

  //ATUALIZAR UM PRODUTO
  Future<void> atualizarUsuario(UsuarioModel usuario) async {
    await Usuariodao().alterarUsuario(usuario);
    carregarUsuarios();
  }

  //REMOVER UM USUARIO
  Future<void> removerUsuario(int id) async {
    await Usuariodao().removerUsuario(id);
    carregarUsuarios();
  }
}
