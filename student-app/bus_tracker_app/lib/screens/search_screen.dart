import 'package:flutter/material.dart';
import 'map_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  String query = '';

  final List<Map<String, dynamic>> allBuses = [
    {'id': 'BUS_001', 'route': 'Route A — Main Gate', 'time': '8:30 AM', 'active': true, 'stops': '12 Stops'},
    {'id': 'BUS_002', 'route': 'Route B — North Gate', 'time': '8:45 AM', 'active': true, 'stops': '8 Stops'},
    {'id': 'BUS_003', 'route': 'Route C — South Stop', 'time': '9:00 AM', 'active': false, 'stops': '10 Stops'},
  ];

  List<Map<String, dynamic>> get filtered => allBuses
      .where((b) =>
          b['id'].toLowerCase().contains(query.toLowerCase()) ||
          b['route'].toLowerCase().contains(query.toLowerCase()))
      .toList();

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
                    const Text('Search Bus',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── SEARCH BAR ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.15)),
                  ),
                  child: TextField(
                    controller: searchController,
                    autofocus: true,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (val) => setState(() => query = val),
                    decoration: InputDecoration(
                      hintText: 'Search by Bus ID or Route...',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.35)),
                      prefixIcon: const Icon(Icons.search_rounded, color: Colors.white38),
                      suffixIcon: query.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              searchController.clear();
                              setState(() => query = '');
                            },
                            child: const Icon(Icons.close_rounded, color: Colors.white38),
                          )
                        : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ── RESULTS ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    query.isEmpty ? 'All Buses' : '${filtered.length} Results',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: filtered.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off_rounded,
                            color: Colors.white24, size: 60),
                          const SizedBox(height: 12),
                          Text('No buses found',
                            style: TextStyle(color: Colors.white38, fontSize: 16)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final bus = filtered[index];
                        final isOnline = bus['active'] as bool;
                        return GestureDetector(
                          onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => MapScreen(busId: bus['id']))),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isOnline
                                  ? Colors.green.withOpacity(0.25)
                                  : Colors.white.withOpacity(0.08),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 46, height: 46,
                                  decoration: BoxDecoration(
                                    color: isOnline
                                      ? Colors.green.withOpacity(0.15)
                                      : Colors.white.withOpacity(0.07),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(Icons.directions_bus_rounded,
                                    color: isOnline ? Colors.green : Colors.white38,
                                    size: 24),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(bus['id'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(bus['route'],
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isOnline
                                      ? Colors.green.withOpacity(0.15)
                                      : Colors.red.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    isOnline ? 'LIVE' : 'OFF',
                                    style: TextStyle(
                                      color: isOnline ? Colors.green : Colors.red,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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