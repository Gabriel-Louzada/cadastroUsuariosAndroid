import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teste_bd/dao/UsuarioDao.dart';

Future<Database> getDataBase() async {
  final String path = join(await getDatabasesPath(), "usuario.db");
  return openDatabase(path, onCreate: (db, version) {
    db.execute(Usuariodao.create);
  }, version: 1);
}
