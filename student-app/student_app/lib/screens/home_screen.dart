import 'package:flutter/material.dart';
import 'map_screen.dart';
import 'all_buses_map_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';
import 'notifications_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  final String studentName;
  final String rollNumber;

  const HomeScreen({
    super.key,
    required this.studentName,
    required this.rollNumber,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> buses = const [
    {'id': 'BUS_001', 'route': 'Route A — Main Gate', 'time': '8:30 AM', 'active': true, 'stops': '12 Stops'},
    {'id': 'BUS_002', 'route': 'Route B — North Gate', 'time': '8:45 AM', 'active': true, 'stops': '8 Stops'},
    {'id': 'BUS_003', 'route': 'Route C — South Stop', 'time': '9:00 AM', 'active': false, 'stops': '10 Stops'},
  ];

  @override
  Widget build(BuildContext context) {
    final screens = [
      _buildHome(context),
      const AllBusesMapScreen(),
      const HistoryScreen(),
      ProfileScreen(
        studentName: widget.studentName,
        rollNumber: widget.rollNumber,
      ),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A1628), Color(0xFF0F3460), Color(0xFF0A1628)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(child: screens[_selectedIndex]),

              // ── BOTTOM NAV ──
              Container(
                margin: const EdgeInsets.fromLTRB(22, 0, 22, 16),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _navItem(Icons.home_rounded, 'Home', 0),
                    _navItem(Icons.map_outlined, 'Map', 1),
                    _navItem(Icons.history_rounded, 'History', 2),
                    _navItem(Icons.person_outline_rounded, 'Profile', 3),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHome(BuildContext context) {
    final now = DateTime.now();
    final hour = now.hour;
    String greeting = hour < 12 ? 'Good Morning' : hour < 17 ? 'Good Afternoon' : 'Good Evening';
    String emoji = hour < 12 ? '🌅' : hour < 17 ? '☀️' : '🌙';

    return Column(
      children: [
        // ── TOP HEADER ──
        Padding(
          padding: const EdgeInsets.fromLTRB(22, 20, 22, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$greeting $emoji',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 13,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(widget.studentName.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // ── SEARCH BUTTON ──
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SearchScreen())),
                    child: _iconButton(Icons.search_rounded),
                  ),
                  const SizedBox(width: 10),
                  // ── NOTIFICATION BUTTON ──
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const NotificationsScreen())),
                    child: Stack(
                      children: [
                        _iconButton(Icons.notifications_outlined),
                        Positioned(
                          top: 6, right: 6,
                          child: Container(
                            width: 8, height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 22),

        // ── STATS ROW ──
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            children: [
              _statCard('2', 'Live Buses', Colors.green, Icons.directions_bus),
              const SizedBox(width: 12),
              _statCard('3', 'Total Routes', Colors.blue, Icons.route),
              const SizedBox(width: 12),
              _statCard('~8', 'Avg ETA (min)', Colors.orange, Icons.timer),
            ],
          ),
        ),

        const SizedBox(height: 22),

        // ── LIVE BANNER ──
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green.withOpacity(0.2),
                  Colors.teal.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.green.withOpacity(0.35)),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.15),
                  blurRadius: 20,
                  spreadRadius: 1,
                )
              ],
            ),
            child: const Row(
              children: [
                Icon(Icons.circle, color: Colors.green, size: 8),
                SizedBox(width: 10),
                Text('2 Buses are live and on route',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text('LIVE',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 22),

        // ── SECTION TITLE ──
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Available Buses',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
              // ── SEE ALL BUTTON ──
              GestureDetector(
                onTap: () => setState(() => _selectedIndex = 1),
                child: Text('See all',
                  style: TextStyle(
                    color: Colors.blue.shade300,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // ── BUS LIST ──
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            itemCount: buses.length,
            itemBuilder: (context, index) {
              final bus = buses[index];
              final bool isOnline = bus['active'];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MapScreen(busId: bus['id']!),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isOnline
                        ? Colors.green.withOpacity(0.25)
                        : Colors.white.withOpacity(0.08),
                      width: 1.2,
                    ),
                    boxShadow: isOnline ? [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.08),
                        blurRadius: 20,
                        spreadRadius: 2,
                      )
                    ] : [],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 52, height: 52,
                        decoration: BoxDecoration(
                          color: isOnline
                            ? Colors.green.withOpacity(0.15)
                            : Colors.white.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isOnline
                              ? Colors.green.withOpacity(0.3)
                              : Colors.white.withOpacity(0.1),
                          ),
                        ),
                        child: Icon(Icons.directions_bus_rounded,
                          color: isOnline ? Colors.green : Colors.white38,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(bus['id']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: isOnline
                                      ? Colors.green.withOpacity(0.2)
                                      : Colors.red.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    isOnline ? 'LIVE' : 'OFF',
                                    style: TextStyle(
                                      color: isOnline ? Colors.green : Colors.red,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(bus['route']!,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.location_on_outlined,
                                  color: Colors.white38, size: 12),
                                const SizedBox(width: 3),
                                Text(bus['stops']!,
                                  style: const TextStyle(
                                    color: Colors.white38,
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Icon(Icons.access_time_rounded,
                                  color: Colors.white38, size: 12),
                                const SizedBox(width: 3),
                                Text(bus['time']!,
                                  style: const TextStyle(
                                    color: Colors.white38,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 34, height: 34,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.arrow_forward_ios_rounded,
                          color: Colors.white38, size: 14),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final bool active = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
            color: active ? Colors.blue.shade300 : Colors.white38,
            size: 22,
          ),
          const SizedBox(height: 4),
          Text(label,
            style: TextStyle(
              color: active ? Colors.blue.shade300 : Colors.white38,
              fontSize: 10,
              fontWeight: active ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon) {
    return Container(
      width: 40, height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Icon(icon, color: Colors.white70, size: 20),
    );
  }

  Widget _statCard(String value, String label, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(height: 6),
            Text(value,
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            Text(label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.45),
                fontSize: 9,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}