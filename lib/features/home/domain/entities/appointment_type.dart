import 'package:flutter/material.dart';

enum AppointmentType {
  doctor(color: Color(0xFF4CAF50), icon: Icons.local_hospital),
  ultrasound(color: Color(0xFF2196F3), icon: Icons.medical_services),
  meeting(color: Color(0xFFFF9800), icon: Icons.meeting_room),
  other(color: Color(0xFF9C27B0), icon: Icons.event);

  const AppointmentType({required this.color, required this.icon});

  final Color color;
  final IconData icon;
}
