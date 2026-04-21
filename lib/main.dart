import 'package:flutter/material.dart';
import 'screens/lista_canciones_screen.dart';

void main() {
  runApp(const MiAppDeMusica());
}

class MiAppDeMusica extends StatelessWidget {
  const MiAppDeMusica({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const ListaCanciones(),
    );
  }
}
