import 'package:equatable/equatable.dart';
import 'package:gebelik_aapp/features/home/domain/entities/appointment_model.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object> get props => [];
}

class CalendarInitial extends CalendarState {}

class CalendarLoaded extends CalendarState {
  final DateTime selectedDate;
  final DateTime currentMonth;
  final List<Appointment> appointments;

  const CalendarLoaded({
    required this.selectedDate,
    required this.currentMonth,
    required this.appointments,
  });

  CalendarLoaded copyWith({
    DateTime? selectedDate,
    DateTime? currentMonth,
    List<Appointment>? appointments,
  }) {
    return CalendarLoaded(
      selectedDate: selectedDate ?? this.selectedDate,
      currentMonth: currentMonth ?? this.currentMonth,
      appointments: appointments ?? this.appointments,
    );
  }

  @override
  List<Object> get props => [selectedDate, currentMonth, appointments];
}

class CalendarError extends CalendarState {
  final String message;

  const CalendarError(this.message);

  @override
  List<Object> get props => [message];
}
