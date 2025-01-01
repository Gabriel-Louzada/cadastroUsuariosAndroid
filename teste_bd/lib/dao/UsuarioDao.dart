import 'package:teste_bd/data/database.dart';
import 'package:teste_bd/model/UsuarioModel.dart';

class Usuariodao {
  static const String nomeTabela = 'usuario';
  static const String id = 'id';
  static const String nome = 'nome';
  static const String idade = 'idade';
  static const String email = 'email';
  static const String imagem = 'imagem';

  static const String create = '''
  CREATE TABLE IF NOT EXISTS $nomeTabela(
  $id INTEGER PRIMARY KEY AUTOINCREMENT,
  $nome  TEXT,
  $idade INTEGER,
  $email TEXT,
  $imagem TEXT
  )
''';

//METODO PARA INSERIR DADOS.
  Future<int> inserirUsuario(UsuarioModel usuario) async {
    final db = await getDataBase();
    const sqlInsert =
        ''' INSERT INTO $nomeTabela($nome, $idade, $email, $imagem) VALUES (?,?,?,?)''';
    final resultado = await db.rawInsert(sqlInsert,
        [usuario.nome, usuario.idade, usuario.email, usuario.imagem]);
    return resultado; // retorna o id do usuario.
  }

  inserirUsuarioTeste() async {
    await inserirUsuario(UsuarioModel(
        nome: "Gabriel Louzada",
        idade: 25,
        email: "gsouzalouzada@gmail.com",
        imagem:
            "/data/user/0/com.example.teste_bd/cache/e529e9e0-4472-4cf2-9490-71d1290f1e4a/8ffd96e8-34c5-45e0-9960-8fad3e203a66-1_all_950.jpg"));
  }

//METODO PARA LISTAR TODOS OS DADOS.
  Future<List<UsuarioModel>> listarTodosUsuarios() async {
    final db = await getDataBase();
    //sql puro
    const sqlSelect =
        'SELECT $id, $nome,$idade, $email, $imagem FROM $nomeTabela';
    final List<Map<String, dynamic>> resultado =
        await db.rawQuery(sqlSelect); // retorno do banco de dados
    List<UsuarioModel> usuarios =
        resultado.map((map) => UsuarioModel.fromMap(map)).toList();
    //CONVERTENDO O RETORNO DO BANCO DE DADOS PARA UMA LISTA DE USUARIOS MODEL
    return usuarios;
  }

//METODO PARA ATUALIZAR OS DADOS.
  Future<int> alterarUsuario(UsuarioModel usuario) async {
    final db = await getDataBase();
    const sqlUpdate = '''
    UPDATE $nomeTabela
       SET $nome = ?,
           $idade = ?,
           $email = ?,
           $imagem = ?
     WHERE $id = ?''';
    final retorno = await db.rawUpdate(sqlUpdate, [
      usuario.nome,
      usuario.idade,
      usuario.email,
      usuario.imagem,
      usuario.id,
    ]);
    return retorno; // retorna o numero de linhas afetadas.
  }

//METODO DE DELETAR OS DADOS.
  Future<int> removerUsuario(int id) async {
    final db = await getDataBase();
    const sqlDelete = '''DELETE FROM $nomeTabela WHERE id = ?''';
    final resultado = await db.rawDelete(sqlDelete, [id]);
    return resultado; // retornar o numero de linhas deletadas
  }
}
