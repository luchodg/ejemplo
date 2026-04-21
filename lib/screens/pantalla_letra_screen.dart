import 'package:flutter/material.dart';
import 'dart:async';
import '../models/cancion.dart';

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
              style: TextStyle(
                fontSize: _tamanioFuente,
                height: 1.5,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _buildControlPanel(),
        ],
      ),
    );
  }

  Widget _buildControlPanel() {
    return Align(
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
                  onChanged: (val) => setState(() => _tamanioFuente = val),
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
                  onChanged: (val) => setState(() => _velocidadScroll = val),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
