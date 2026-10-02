import 'package:flutter/material.dart';

class PyramidPage extends StatefulWidget {
  const PyramidPage({super.key});

  @override
  State<PyramidPage> createState() => _PyramidPageState();
}

class _PyramidPageState extends State<PyramidPage> {
  final _baseController = TextEditingController();
  final _heightController = TextEditingController();
  final _edgeController = TextEditingController();
  double? _volume;
  double? _perimeter;

  void _calculate() {
    final base = double.tryParse(_baseController.text.replaceAll(',', '.'));
    final height = double.tryParse(_heightController.text.replaceAll(',', '.'));
    final edge = double.tryParse(_edgeController.text.replaceAll(',', '.'));
    if (base == null ||
        height == null ||
        edge == null ||
        base <= 0 ||
        height <= 0 ||
        edge <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan semua nilai dengan angka yang valid.'),
        ),
      );
      return;
    }
    setState(() {
      _volume = base * base * height / 3;
      _perimeter = 4 * base + 4 * edge;
    });
  }

  @override
  void dispose() {
    _baseController.dispose();
    _heightController.dispose();
    _edgeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Piramida')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _HeaderCard(
              icon: Icons.change_history_rounded,
              title: 'Piramida Segiempat',
              subtitle: 'Hitung volume dan keliling piramida.',
            ),
            const SizedBox(height: 18),
            _InputField(
              controller: _baseController,
              label: 'Sisi alas',
              suffix: 'cm',
            ),
            const SizedBox(height: 12),
            _InputField(
              controller: _heightController,
              label: 'Tinggi piramida',
              suffix: 'cm',
            ),
            const SizedBox(height: 12),
            _InputField(
              controller: _edgeController,
              label: 'Sisi miring/tepi',
              suffix: 'cm',
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: FilledButton.icon(
                onPressed: _calculate,
                icon: const Icon(Icons.calculate_rounded),
                label: const Text('Hitung'),
              ),
            ),
            const SizedBox(height: 20),
            if (_volume != null && _perimeter != null)
              _ResultCard(
                values: [
                  ('Volume', '${_volume!.toStringAsFixed(2)} cm³'),
                  ('Keliling', '${_perimeter!.toStringAsFixed(2)} cm'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _HeaderCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEDE7F6),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundColor: Color(0xFF6750A4),
            child: Icon(Icons.change_history_rounded, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(subtitle, style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String suffix;

  const _InputField({
    required this.controller,
    required this.label,
    required this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: label, suffixText: suffix),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final List<(String, String)> values;

  const _ResultCard({required this.values});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            blurRadius: 16,
            color: Color(0x10000000),
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: values
            .map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.$1,
                      style: const TextStyle(color: Colors.black54),
                    ),
                    Text(
                      item.$2,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
