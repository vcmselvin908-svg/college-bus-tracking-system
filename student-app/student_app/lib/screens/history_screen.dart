import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  final List<Map<String, dynamic>> trips = const [
    {'bus': 'BUS_001', 'route': 'Route A — Main Gate', 'date': 'Today', 'time': '8:32 AM', 'status': 'Completed', 'duration': '24 min'},
    {'bus': 'BUS_002', 'route': 'Route B — North Gate', 'date': 'Yesterday', 'time': '8:47 AM', 'status': 'Completed', 'duration': '18 min'},
    {'bus': 'BUS_001', 'route': 'Route A — Main Gate', 'date': 'Yesterday', 'time': '8:30 AM', 'status': 'Completed', 'duration': '22 min'},
    {'bus': 'BUS_003', 'route': 'Route C — South Stop', 'date': '08 Mar', 'time': '9:05 AM', 'status': 'Missed', 'duration': '—'},
    {'bus': 'BUS_001', 'route': 'Route A — Main Gate', 'date': '07 Mar', 'time': '8:31 AM', 'status': 'Completed', 'duration': '25 min'},
    {'bus': 'BUS_002', 'route': 'Route B — North Gate', 'date': '06 Mar', 'time': '8:44 AM', 'status': 'Completed', 'duration': '19 min'},
  ];

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
              const Text('Trip History',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.12)),
                ),
                child: const Text('Filter',
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ── STATS ──
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            children: [
              _statBox('12', 'Total\nTrips', Colors.blue),
              const SizedBox(width: 12),
              _statBox('11', 'Completed', Colors.green),
              const SizedBox(width: 12),
              _statBox('1', 'Missed', Colors.red),
            ],
          ),
        ),

        const SizedBox(height: 20),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Recent Trips',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index];
              final isCompleted = trip['status'] == 'Completed';
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 46, height: 46,
                      decoration: BoxDecoration(
                        color: isCompleted
                          ? Colors.green.withOpacity(0.15)
                          : Colors.red.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        isCompleted
                          ? Icons.check_circle_outline_rounded
                          : Icons.cancel_outlined,
                        color: isCompleted ? Colors.green : Colors.red,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(trip['bus'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          Text(trip['route'],
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.45),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.calendar_today_outlined,
                                color: Colors.white38, size: 11),
                              const SizedBox(width: 4),
                              Text('${trip['date']} • ${trip['time']}',
                                style: TextStyle(
                                  color: Colors.white38,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: isCompleted
                              ? Colors.green.withOpacity(0.15)
                              : Colors.red.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(trip['status'],
                            style: TextStyle(
                              color: isCompleted ? Colors.green : Colors.red,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(trip['duration'],
                          style: TextStyle(
                            color: Colors.white38,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _statBox(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
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
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}