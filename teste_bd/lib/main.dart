import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_bd/provider/provider.dart';
import 'package:teste_bd/screen/telaInicial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UsuarioProvider(),
      child: MaterialApp(
        title: 'Teste banco usuarios',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Telainicial(),
      ),
    );
  }
}
