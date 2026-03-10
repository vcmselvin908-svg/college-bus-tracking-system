import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  final List<Map<String, dynamic>> notifications = const [
    {
      'title': 'BUS_001 Arriving Soon!',
      'body': 'Your bus is 5 minutes away from Main Gate.',
      'time': '2 mins ago',
      'icon': Icons.directions_bus_rounded,
      'color': 0xFF4CAF50,
      'read': false,
    },
    {
      'title': 'BUS_002 Delayed',
      'body': 'Route B is delayed by 10 minutes due to traffic.',
      'time': '15 mins ago',
      'icon': Icons.warning_amber_rounded,
      'color': 0xFFFF9800,
      'read': false,
    },
    {
      'title': 'BUS_003 Off Route',
      'body': 'Route C bus is currently offline.',
      'time': '1 hr ago',
      'icon': Icons.cancel_outlined,
      'color': 0xFFF44336,
      'read': true,
    },
    {
      'title': 'Trip Completed',
      'body': 'BUS_001 has completed Route A successfully.',
      'time': 'Yesterday',
      'icon': Icons.check_circle_outline_rounded,
      'color': 0xFF2196F3,
      'read': true,
    },
    {
      'title': 'New Route Added',
      'body': 'Route D — East Campus has been added.',
      'time': '2 days ago',
      'icon': Icons.add_road_rounded,
      'color': 0xFF9C27B0,
      'read': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
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
              // ── HEADER ──
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 40, height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white.withOpacity(0.12)),
                            ),
                            child: const Icon(Icons.arrow_back_ios_new_rounded,
                              color: Colors.white70, size: 16),
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Text('Notifications',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.red.withOpacity(0.3)),
                      ),
                      child: const Text('2 New',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final n = notifications[index];
                    final color = Color(n['color']);
                    final isUnread = !n['read'];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isUnread
                          ? Colors.white.withOpacity(0.09)
                          : Colors.white.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isUnread
                            ? color.withOpacity(0.3)
                            : Colors.white.withOpacity(0.07),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(n['icon'] as IconData,
                              color: color, size: 22),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(n['title'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: isUnread
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    if (isUnread)
                                      Container(
                                        width: 8, height: 8,
                                        decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(n['body'],
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(n['time'],
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.3),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}