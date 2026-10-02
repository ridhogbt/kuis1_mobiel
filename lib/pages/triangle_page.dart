import 'dart:math' as math;
import 'package:flutter/material.dart';

class TrianglePage extends StatefulWidget {
  const TrianglePage({super.key});

  @override
  State<TrianglePage> createState() => _TrianglePageState();
}

class _TrianglePageState extends State<TrianglePage> {
  String _type = 'Sama Kaki';
  final _a = TextEditingController();
  final _b = TextEditingController();
  final _c = TextEditingController();
  double? _area;
  double? _perimeter;

  void _calculate() {
    final a = double.tryParse(_a.text.replaceAll(',', '.'));
    final b = double.tryParse(_b.text.replaceAll(',', '.'));
    final c = double.tryParse(_c.text.replaceAll(',', '.'));
    if (a == null || b == null || c == null || a <= 0 || b <= 0 || c <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan semua nilai dengan angka yang valid.'),
        ),
      );
      return;
    }
    double area;
    double perimeter;
    if (_type == 'Sama Kaki') {
      final height = math.sqrt(math.max(0, b * b - (a * a / 4)));
      area = a * height / 2;
      perimeter = a + 2 * b;
    } else if (_type == 'Sama Sisi') {
      area = math.sqrt(3) / 4 * a * a;
      perimeter = 3 * a;
    } else {
      area = a * b / 2;
      perimeter = a + b + c;
    }
    setState(() {
      _area = area;
      _perimeter = perimeter;
    });
  }

  void _reset() {
    _a.clear();
    _b.clear();
    _c.clear();
    setState(() {
      _area = null;
      _perimeter = null;
    });
  }

  @override
  void dispose() {
    _a.dispose();
    _b.dispose();
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labels = switch (_type) {
      'Sama Sisi' => ('Sisi', 'Sisi tambahan', 'Sisi tambahan'),
      'Siku-siku' => ('Alas', 'Tinggi', 'Sisi miring'),
      _ => ('Alas', 'Sisi sama kaki', 'Sisi sama kaki'),
    };
    return Scaffold(
      appBar: AppBar(title: const Text('Segitiga')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2F1),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFF006A6A),
                    child: Icon(Icons.category_rounded, color: Colors.white),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Pilih jenis segitiga lalu masukkan ukuran untuk menghitung luas dan keliling.',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            DropdownButtonFormField<String>(
              value: _type,
              decoration: const InputDecoration(labelText: 'Jenis segitiga'),
              items: const [
                DropdownMenuItem(
                  value: 'Sama Kaki',
                  child: Text('Segitiga Sama Kaki'),
                ),
                DropdownMenuItem(
                  value: 'Sama Sisi',
                  child: Text('Segitiga Sama Sisi'),
                ),
                DropdownMenuItem(
                  value: 'Siku-siku',
                  child: Text('Segitiga Siku-siku'),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _type = value;
                  _area = null;
                  _perimeter = null;
                });
              },
            ),
            const SizedBox(height: 12),
            _Field(controller: _a, label: labels.$1),
            const SizedBox(height: 12),
            _Field(controller: _b, label: labels.$2),
            const SizedBox(height: 12),
            _Field(controller: _c, label: labels.$3),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _calculate,
                    icon: const Icon(Icons.calculate_rounded),
                    label: const Text('Hitung'),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton.filledTonal(
                  onPressed: _reset,
                  icon: const Icon(Icons.refresh_rounded),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_area != null && _perimeter != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    _ResultRow(
                      label: 'Luas',
                      value: '${_area!.toStringAsFixed(2)} cm²',
                    ),
                    const Divider(height: 24),
                    _ResultRow(
                      label: 'Keliling',
                      value: '${_perimeter!.toStringAsFixed(2)} cm',
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  const _Field({required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: label, suffixText: 'cm'),
    );
  }
}

class _ResultRow extends StatelessWidget {
  final String label;
  final String value;
  const _ResultRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.black54)),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}
