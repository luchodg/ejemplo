import 'package:flutter/material.dart';
import '../models/cancion.dart';
import 'pantalla_letra_screen.dart';
import '../models/letras.dart';

class ListaCanciones extends StatelessWidget {
  const ListaCanciones({super.key});

  @override
  Widget build(BuildContext context) {
    // Nota: En una app real, esto vendría de un Provider o una API
    final List<Cancion> misCanciones = [
      Cancion('Luces de Neon', cancionNeon),
      Cancion('Flaca', flacaCalamaro),
      Cancion('Mariposas', mariposasEnanitos),
      Cancion('El Olvidao', elOlvidao),
      Cancion("Lindo adorno pa' mi apero ", elToro)
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Playlist de Lucho'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: ListView.builder(
        itemCount: misCanciones.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.library_music),
              title: Text(misCanciones[index].titulo,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PantallaLetraPro(cancion: misCanciones[index]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
