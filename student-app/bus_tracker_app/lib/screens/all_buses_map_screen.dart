import 'package:flutter/material.dart';

class AllBusesMapScreen extends StatefulWidget {
  const AllBusesMapScreen({super.key});

  @override
  State<AllBusesMapScreen> createState() => _AllBusesMapScreenState();
}

class _AllBusesMapScreenState extends State<AllBusesMapScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  final List<Map<String, dynamic>> allBuses = [
    {'id': 'BUS_001', 'route': 'Route A', 'active': true, 'eta': '8 mins', 'x': 0.5, 'y': 0.45},
    {'id': 'BUS_002', 'route': 'Route B', 'active': true, 'eta': '12 mins', 'x': 0.3, 'y': 0.6},
    {'id': 'BUS_003', 'route': 'Route C', 'active': false, 'eta': 'Offline', 'x': 0.7, 'y': 0.35},
  ];

  String selectedBus = 'BUS_001';

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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

            // ── HEADER ──
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 16, 22, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('All Buses',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text('Live positions on map',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.green.withOpacity(0.3)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.circle, color: Colors.green, size: 8),
                        SizedBox(width: 6),
                        Text('2 Live',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── MAP AREA ──
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withOpacity(0.12)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Stack(
                      children: [
                        // Grid
                        CustomPaint(
                          painter: _GridPainter(),
                          child: Container(),
                        ),

                        // Roads
                        CustomPaint(
                          painter: _RoadPainter(),
                          child: Container(),
                        ),

                        // Bus Markers
                        ...allBuses.map((bus) {
                          return LayoutBuilder(
                            builder: (context, constraints) {
                              return Positioned(
                                left: constraints.maxWidth * (bus['x'] as double) - 26,
                                top: constraints.maxHeight * (bus['y'] as double) - 26,
                                child: GestureDetector(
                                  onTap: () => setState(() => selectedBus = bus['id']),
                                  child: AnimatedBuilder(
                                    animation: _pulseAnimation,
                                    builder: (context, child) {
                                      final isSelected = selectedBus == bus['id'];
                                      final isOnline = bus['active'] as bool;
                                      return Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          if (isOnline)
                                            Container(
                                              width: 52 * (isSelected ? _pulseAnimation.value : 1.0),
                                              height: 52 * (isSelected ? _pulseAnimation.value : 1.0),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.green.withOpacity(0.15),
                                              ),
                                            ),
                                          Container(
                                            width: isSelected ? 44 : 36,
                                            height: isSelected ? 44 : 36,
                                            decoration: BoxDecoration(
                                              color: isOnline ? Colors.green : Colors.grey,
                                              shape: BoxShape.circle,
                                              boxShadow: isOnline ? [
                                                BoxShadow(
                                                  color: Colors.green.withOpacity(0.4),
                                                  blurRadius: 12,
                                                  spreadRadius: 2,
                                                )
                                              ] : [],
                                            ),
                                            child: Icon(
                                              Icons.directions_bus_rounded,
                                              color: Colors.white,
                                              size: isSelected ? 22 : 18,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        }),

                        // College marker
                        Positioned(
                          top: 30, right: 40,
                          child: _mapMarker(Icons.school_rounded, 'College', Colors.blue),
                        ),

                        // Stop markers
                        Positioned(
                          bottom: 50, left: 30,
                          child: _mapMarker(Icons.location_on_rounded, 'Stop A', Colors.orange),
                        ),
                        Positioned(
                          bottom: 80, right: 60,
                          child: _mapMarker(Icons.location_on_rounded, 'Stop B', Colors.purple),
                        ),

                        // Compass
                        Positioned(
                          top: 14, left: 14,
                          child: Container(
                            width: 34, height: 34,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white.withOpacity(0.2)),
                            ),
                            child: const Icon(Icons.navigation_rounded,
                              color: Colors.white70, size: 16),
                          ),
                        ),

                        // Zoom buttons
                        Positioned(
                          right: 14, bottom: 60,
                          child: Column(
                            children: [
                              _zoomBtn(Icons.add),
                              const SizedBox(height: 6),
                              _zoomBtn(Icons.remove),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ── BUS SELECTOR ──
            SizedBox(
              height: 80,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: allBuses.length,
                itemBuilder: (context, index) {
                  final bus = allBuses[index];
                  final isSelected = selectedBus == bus['id'];
                  final isOnline = bus['active'] as bool;
                  return GestureDetector(
                    onTap: () => setState(() => selectedBus = bus['id']),
                    child: Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected
                          ? Colors.green.withOpacity(0.15)
                          : Colors.white.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                            ? Colors.green.withOpacity(0.4)
                            : Colors.white.withOpacity(0.1),
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.directions_bus_rounded,
                            color: isOnline ? Colors.green : Colors.grey,
                            size: 22,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(bus['id']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(isOnline ? bus['eta']! : 'Offline',
                                  style: TextStyle(
                                    color: isOnline ? Colors.green : Colors.red,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _mapMarker(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: color.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: color.withOpacity(0.3), blurRadius: 8)
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
        const SizedBox(height: 3),
        Text(label,
          style: TextStyle(color: Colors.white.withOpacity(0.65), fontSize: 9),
        ),
      ],
    );
  }

  Widget _zoomBtn(IconData icon) {
    return Container(
      width: 32, height: 32,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: Icon(icon, color: Colors.white70, size: 16),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.04)
      ..strokeWidth = 1;
    for (double i = 0; i < size.width; i += 30) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 30) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RoadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.07)
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(size.width * 0.1, size.height * 0.3),
      Offset(size.width * 0.9, size.height * 0.5), paint);
    canvas.drawLine(Offset(size.width * 0.4, 0),
      Offset(size.width * 0.5, size.height), paint);
    canvas.drawLine(Offset(0, size.height * 0.65),
      Offset(size.width, size.height * 0.4), paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}