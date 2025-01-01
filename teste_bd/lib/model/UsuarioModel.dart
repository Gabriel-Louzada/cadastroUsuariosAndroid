class UsuarioModel {
  final int? id;
  final String nome;
  final int idade;
  final String email;
  final String? imagem;

  UsuarioModel(
      {this.id,
      required this.nome,
      required this.idade,
      required this.email,
      this.imagem});

//CONVERTE O USUARIO EM UM MAP DE USUARIOS
  Map<String, dynamic> toMap() {
    final map = {'id': id, 'nome': nome, 'idade': idade, 'email': email};

    if (imagem != null) {
      map['imagem'] = imagem;
    }

    return map;
  }

//CONVERTE O MAP DE USUARIOS EM UM USUARIOMODEL
  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      id: map['id'],
      nome: map['nome'],
      idade: map['idade'],
      email: map['email'],
      imagem: map['imagem'],
    );
  }

//CONVERTE O PRODUTO EM UMA STRING
  @override
  String toString() {
    return 'UsuarioModel(id: $id, nome: $nome, idade: $idade , email: $email, imagem: $imagem)';
  }
}
