class UsuarioModel {
  final int? id;
  final String nome;
  final int idade;
  final String email;

  UsuarioModel({this.id, required this.nome, required this.idade, required this.email});

//CONVERTE O USUARIO EM UM MAP DE USUARIOS
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'idade': idade,
      'email': email,
    };
  }

//CONVERTE O MAP DE USUARIOS EM UM USUARIOMODEL
  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      id: map['id'],
      nome: map['nome'],
      idade: map['idade'],
      email: map['email'],
    );
  }

//CONVERTE O PRODUTO EM UMA STRING
  @override
  String toString() {
    return 'UsuarioModel(id: $id, nome: $nome, idade: $idade , email: $email)';
  }
}
