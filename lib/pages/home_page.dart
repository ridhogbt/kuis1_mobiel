import 'package:flutter/material.dart';
import 'pyramid_page.dart';
import 'triangle_page.dart';
import 'time_conversion_page.dart';
import 'day_checker_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final menus = [
      _MenuItem(
        title: 'Piramida',
        subtitle: 'Volume & keliling',
        icon: Icons.change_history_rounded,
        color: const Color(0xFF6750A4),
        page: const PyramidPage(),
      ),
      _MenuItem(
        title: 'Segitiga',
        subtitle: 'Luas & keliling',
        icon: Icons.category_rounded,
        color: const Color(0xFF006A6A),
        page: const TrianglePage(),
      ),
      _MenuItem(
        title: 'Konversi Waktu',
        subtitle: 'WIB, Malaysia & Kanada',
        icon: Icons.access_time_rounded,
        color: const Color(0xFF9A4525),
        page: const TimeConversionPage(),
      ),
      _MenuItem(
        title: 'Cek Hari',
        subtitle: 'Nomor 1 sampai 7',
        icon: Icons.calendar_month_rounded,
        color: const Color(0xFF3F5F91),
        page: const DayCheckerPage(),
      ),
    ];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Halo! 👋',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            Text(
              'Pilih fitur yang ingin kamu gunakan.',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.black54),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6750A4), Color(0xFF8B70C8)],
                ),
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.calculate_rounded, color: Colors.white, size: 38),
                  SizedBox(height: 16),
                  Text(
                    'Kalkulator Bangun & Waktu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(
                    'Hitung, konversi, dan cek informasi dengan mudah.',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: menus.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.94,
              ),
              itemBuilder: (context, index) {
                final item = menus[index];
                return _MenuCard(item: item);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Widget page;

  const _MenuItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.page,
  });
}

class _MenuCard extends StatelessWidget {
  final _MenuItem item;

  const _MenuCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => item.page));
      },
      child: Ink(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              blurRadius: 18,
              offset: Offset(0, 7),
              color: Color(0x12000000),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: item.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(item.icon, color: item.color, size: 28),
            ),
            const Spacer(),
            Text(
              item.title,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              item.subtitle,
              style: const TextStyle(color: Colors.black54, fontSize: 12),
            ),
            const SizedBox(height: 12),
            Icon(Icons.arrow_forward_rounded, color: item.color, size: 20),
          ],
        ),
      ),
    );
  }
}
