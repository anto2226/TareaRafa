import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compatibilidad',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const CompatibilidadPage(),
    );
  }
}

class CompatibilidadPage extends StatefulWidget {
  const CompatibilidadPage({super.key});

  @override
  State<CompatibilidadPage> createState() => _CompatibilidadPageState();
}

class _CompatibilidadPageState extends State<CompatibilidadPage> {
  final TextEditingController _nombre1 = TextEditingController();
  final TextEditingController _nombre2 = TextEditingController();
  int? _resultado;

  int calcularCompatibilidad(String nombre1, String nombre2) {
    final texto = (nombre1 + nombre2).toLowerCase();
    int suma = 0;
    for (var c in texto.runes) {
      suma += c;
    }
    return suma % 101;
  }

  String mensaje(int porcentaje) {
    if (porcentaje >= 80) return '💘 ¡Alma gemela!';
    if (porcentaje >= 60) return '😍 ¡Muy buena pareja!';
    if (porcentaje >= 40) return '🙂 Compatibles';
    if (porcentaje >= 20) return '😐 Más o menos...';
    return '💔 No son muy compatibles';
  }

  void calcular() {
    if (_nombre1.text.isEmpty || _nombre2.text.isEmpty) return;
    setState(() {
      _resultado = calcularCompatibilidad(_nombre1.text, _nombre2.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('💕 Test de Compatibilidad'),
        backgroundColor: Colors.pink[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nombre1,
              decoration: const InputDecoration(
                labelText: 'Nombre 1',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            const Text('❤️', style: TextStyle(fontSize: 32)),
            const SizedBox(height: 16),
            TextField(
              controller: _nombre2,
              decoration: const InputDecoration(
                labelText: 'Nombre 2',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: calcular,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
              ),
              child: const Text(
                'Calcular compatibilidad',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 32),
            if (_resultado != null) ...[
              Text(
                '$_resultado%',
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
              Text(mensaje(_resultado!), style: const TextStyle(fontSize: 24)),
            ],
          ],
        ),
      ),
    );
  }
}
