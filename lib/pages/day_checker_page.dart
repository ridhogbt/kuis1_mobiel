import 'package:flutter/material.dart';

class DayCheckerPage extends StatefulWidget {
  const DayCheckerPage({super.key});

  @override
  State<DayCheckerPage> createState() => _DayCheckerPageState();
}

class _DayCheckerPageState extends State<DayCheckerPage> {
  final _controller = TextEditingController();
  String? _day;

  void _checkDay() {
    final number = int.tryParse(_controller.text.trim());
    const days = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    if (number == null || number < 1 || number > 7) {
      setState(() => _day = null);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan angka dari 1 sampai 7.')),
      );
      return;
    }
    setState(() => _day = days[number - 1]);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const days = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Cek Hari')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: const Color(0xFFE7EEF9),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    color: Color(0xFF3F5F91),
                    size: 36,
                  ),
                  SizedBox(height: 14),
                  Text(
                    'Cek Hari dari Nomor',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '1 = Senin sampai 7 = Minggu.',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
              decoration: const InputDecoration(
                labelText: 'Masukkan nomor hari',
                hintText: 'Contoh: 1',
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: FilledButton.icon(
                onPressed: _checkDay,
                icon: const Icon(Icons.search_rounded),
                label: const Text('Cek Hari'),
              ),
            ),
            const SizedBox(height: 20),
            if (_day != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 28,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.event_available_rounded,
                      color: Color(0xFF3F5F91),
                      size: 52,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Hari yang dipilih adalah',
                      style: TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _day!,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Daftar hari',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: 10),
            ...List.generate(
              days.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _DayRow(number: index + 1, day: days[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DayRow extends StatelessWidget {
  final int number;
  final String day;
  const _DayRow({required this.number, required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 17,
            backgroundColor: const Color(0xFFE7EEF9),
            child: Text(
              '$number',
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF3F5F91),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Text(day, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
