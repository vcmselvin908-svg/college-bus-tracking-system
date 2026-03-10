import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  // Bus location listen பண்ணும்
  static Stream<Map<String, dynamic>?> listenToBus(String busId) {
    final ref = FirebaseDatabase.instance.ref('buses/$busId');
    return ref.onValue.map((event) {
      final data = event.snapshot.value;
      if (data != null) {
        return Map<String, dynamic>.from(data as Map);
      }
      return null;
    });
  }

  // எல்லா buses-உம் listen பண்ணும்
  static Stream<Map<String, dynamic>?> listenToAllBuses() {
    final ref = FirebaseDatabase.instance.ref('buses');
    return ref.onValue.map((event) {
      final data = event.snapshot.value;
      if (data != null) {
        return Map<String, dynamic>.from(data as Map);
      }
      return null;
    });
  }
}