import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MiAppDeMusica());
}

class Cancion {
  final String titulo;
  final String letra;
  Cancion(this.titulo, this.letra);
}

class MiAppDeMusica extends StatelessWidget {
  const MiAppDeMusica({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const ListaCanciones(),
    );
  }
}

class ListaCanciones extends StatelessWidget {
  const ListaCanciones({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Cancion> misCanciones = [
      Cancion(
          'Muchachos',
          'Intro: RE  LA  SOL  RE  LA\n\n'
              'RE\n'
              'En Argentina nací\n'
              'LA\n'
              'tierra de Diego y Lionel\n'
              'SOL               RE\n'
              'de los pibes de Malvinas\n'
              'LA\n'
              'que jamás olvidaré.\n\n'
              'RE\n'
              'No te lo puedo explicar\n'
              'LA\n'
              'porque no vas a entender\n'
              'SOL               RE\n'
              'las finales que perdimos\n'
              'LA\n'
              'tantos años las lloré.\n\n'
              'RE\n'
              'Pero eso se terminó\n'
              'LA\n'
              'porque en el Maracaná\n'
              'SOL             RE\n'
              'la final con los brazucas\n'
              'LA\n'
              'la volvió a ganar papá.\n\n'
              'SOL        LA        RE\n'
              'Muchachos, ahora nos volvimos a ilusionar\n'
              'SOL           LA         RE\n'
              'quiero ganar la tercera, quiero ser campeón mundial\n'
              'SOL               LA         RE      RE/DO#  SIm\n'
              'y al Diego, en el cielo lo podemos ver\n'
              '          SOL          LA         RE\n'
              'con don Diego y con la Tota, alentándolo a Lionel.'),
      Cancion('Ji Ji Ji', 'REm  DO  SIb  LA7\nNo lo soñé...\n' * 5),
    ];

    return Scaffold(
      appBar: AppBar(
          title: const Text('Playlist de Lucho'),
          backgroundColor: Colors.blue.shade100),
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
                  )),
            ),
          );
        },
      ),
    );
  }
}

class PantallaLetraPro extends StatefulWidget {
  final Cancion cancion;
  const PantallaLetraPro({super.key, required this.cancion});

  @override
  State<PantallaLetraPro> createState() => _PantallaLetraProState();
}

class _PantallaLetraProState extends State<PantallaLetraPro> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

  double _velocidadScroll = 0.0;
  double _tamanioFuente = 18.0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_velocidadScroll > 0 && _scrollController.hasClients) {
        double newPos =
            _scrollController.position.pixels + (_velocidadScroll / 2);
        if (newPos <= _scrollController.position.maxScrollExtent) {
          _scrollController.jumpTo(newPos);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.cancion.titulo)),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(15, 20, 80, 40),
            child: Text(
              widget.cancion.letra,
              textAlign:
                  TextAlign.left, // Izquierda para que los acordes no se corran
              style: TextStyle(
                fontSize: _tamanioFuente,
                height: 1.5,
                fontFamily:
                    'monospace', // <--- CLAVE: Para que los acordes coincidan
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // PANEL DE CONTROLES
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                border: Border(left: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.text_fields, size: 20),
                  Expanded(
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Slider(
                        value: _tamanioFuente,
                        min: 10.0,
                        max: 40.0,
                        onChanged: (val) =>
                            setState(() => _tamanioFuente = val),
                      ),
                    ),
                  ),
                  const Divider(),
                  const Icon(Icons.play_arrow, size: 20),
                  Expanded(
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Slider(
                        value: _velocidadScroll,
                        min: 0.0,
                        max: 10.0,
                        onChanged: (val) =>
                            setState(() => _velocidadScroll = val),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
