import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String studentName;
  final String rollNumber;

  const ProfileScreen({
    super.key,
    required this.studentName,
    required this.rollNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── HEADER ──
        Padding(
          padding: const EdgeInsets.fromLTRB(22, 20, 22, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.12)),
                ),
                child: const Icon(Icons.edit_outlined,
                  color: Colors.white70, size: 18),
              ),
            ],
          ),
        ),

        const SizedBox(height: 28),

        // ── AVATAR ──
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 90, height: 90,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1A6FD4), Color(0xFF0F3460)],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 3,
                  )
                ],
              ),
              child: Center(
                child: Text(
                  studentName.isNotEmpty
                    ? studentName[0].toUpperCase()
                    : 'S',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Container(
              width: 26, height: 26,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF0A1628), width: 2),
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 14),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // ── NAME & ROLL ──
        Text(studentName.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blue.withOpacity(0.3)),
          ),
          child: Text(rollNumber,
            style: TextStyle(
              color: Colors.blue.shade300,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(height: 30),

        // ── STATS ──
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            children: [
              _statBox('12', 'Trips\nTaken', Colors.green),
              const SizedBox(width: 12),
              _statBox('BUS_001', 'Favourite\nBus', Colors.blue),
              const SizedBox(width: 12),
              _statBox('8 min', 'Avg\nETA', Colors.orange),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // ── MENU ITEMS ──
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                _sectionTitle('My Bus'),
                _menuItem(Icons.directions_bus_rounded, 'My Route', 'BUS_001 — Route A', Colors.green),
                _menuItem(Icons.location_on_outlined, 'My Stop', 'Main Gate Stop', Colors.blue),
                _menuItem(Icons.notifications_active_outlined, 'Notifications', 'Arrival alerts ON', Colors.orange),

                const SizedBox(height: 16),
                _sectionTitle('Account'),
                _menuItem(Icons.school_outlined, 'College', 'Dr. G.U. Popes College', Colors.purple),
                _menuItem(Icons.badge_outlined, 'Department', 'Computer Science', Colors.teal),
                _menuItem(Icons.phone_outlined, 'Contact', 'Add phone number', Colors.pink),

                const SizedBox(height: 16),
                _sectionTitle('Settings'),
                _menuItem(Icons.dark_mode_outlined, 'Theme', 'Dark Mode', Colors.indigo),
                _menuItem(Icons.language_outlined, 'Language', 'English', Colors.cyan),
                _menuItem(Icons.help_outline_rounded, 'Help & Support', 'FAQ & Contact', Colors.amber),

                const SizedBox(height: 16),

                // Logout
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.red.withOpacity(0.3)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout_rounded, color: Colors.red, size: 18),
                      SizedBox(width: 8),
                      Text('Logout',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _statBox(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Text(value,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.45),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.4),
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String title, String subtitle, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        children: [
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded,
            color: Colors.white24, size: 13),
        ],
      ),
    );
  }
}