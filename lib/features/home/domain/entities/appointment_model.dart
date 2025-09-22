import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gebelik_aapp/features/home/domain/entities/appointment_type.dart';

class Appointment extends Equatable {
  final String id;
  final String title;
  final DateTime dateTime;
  final AppointmentType type;

  const Appointment({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.type,
  });

  Appointment copyWith({
    String? id,
    String? title,
    DateTime? dateTime,
    AppointmentType? type,
  }) {
    return Appointment(
      id: id ?? this.id,
      title: title ?? this.title,
      dateTime: dateTime ?? this.dateTime,
      type: type ?? this.type,
    );
  }

  @override
  List<Object> get props => [id, title, dateTime, type];
}
