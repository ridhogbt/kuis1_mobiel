import 'dart:async';

import 'package:flutter/material.dart';

class TimeConversionPage extends StatefulWidget {
  const TimeConversionPage({super.key});

  @override
  State<TimeConversionPage> createState() => _TimeConversionPageState();
}

class _TimeConversionPageState extends State<TimeConversionPage> {
  Timer? _timer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _currentTime = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  DateTime _getMalaysiaTime() {
    return _currentTime.toUtc().add(const Duration(hours: 8));
  }

  DateTime _getTorontoTime() {
    final utc = _currentTime.toUtc();
    final isDaylightSaving = _isTorontoDaylightSaving(utc);
    final offset = isDaylightSaving ? -4 : -5;

    return utc.add(Duration(hours: offset));
  }

  bool _isTorontoDaylightSaving(DateTime utc) {
    final year = utc.year;

    final marchSunday = _lastSundayOfMonth(year, 3);
    final novemberSunday = _lastSundayOfMonth(year, 11);

    final daylightStart = DateTime.utc(year, 3, marchSunday, 7);

    final daylightEnd = DateTime.utc(year, 11, novemberSunday, 6);

    return !utc.isBefore(daylightStart) && utc.isBefore(daylightEnd);
  }

  int _lastSundayOfMonth(int year, int month) {
    final lastDay = DateTime(year, month + 1, 0);
    return lastDay.day - (lastDay.weekday % 7);
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    final second = time.second.toString().padLeft(2, '0');

    return '$hour:$minute:$second';
  }

  String _formatDate(DateTime time) {
    const days = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];

    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return '${days[time.weekday - 1]}, ${time.day} ${months[time.month - 1]} ${time.year}';
  }

  Widget _buildTimeCard({
    required String country,
    required String city,
    required String timezone,
    required DateTime time,
    required IconData icon,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                size: 30,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    country,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    city,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    timezone,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _formatTime(time),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDate(time),
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final malaysiaTime = _getMalaysiaTime();
    final torontoTime = _getTorontoTime();

    return Scaffold(
      appBar: AppBar(title: const Text('Konversi Waktu'), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _currentTime = DateTime.now();
          });
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    color: Colors.white,
                    size: 42,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Waktu Real-Time',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Jam diperbarui setiap detik',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            _buildTimeCard(
              country: 'Indonesia',
              city: 'Jakarta',
              timezone: 'WIB • UTC+7',
              time: _currentTime,
              icon: Icons.location_on_rounded,
            ),
            _buildTimeCard(
              country: 'Malaysia',
              city: 'Kuala Lumpur',
              timezone: 'MYT • UTC+8',
              time: malaysiaTime,
              icon: Icons.location_city_rounded,
            ),
            _buildTimeCard(
              country: 'Kanada',
              city: 'Toronto',
              timezone: 'ET • UTC-4 / UTC-5',
              time: torontoTime,
              icon: Icons.public_rounded,
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Waktu mengikuti jam perangkat',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
