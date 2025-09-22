import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gebelik_aapp/features/home/domain/entities/appointment_model.dart';
import 'package:gebelik_aapp/features/home/domain/entities/appointment_type.dart';
import 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarInitial());

  void loadCalendar() {
    final now = DateTime.now();
    final appointments = _generateSampleAppointments();

    emit(
      CalendarLoaded(
        selectedDate: now, // Güncel tarihi seç
        currentMonth: DateTime(now.year, now.month), // Güncel ayı göster
        appointments: appointments,
      ),
    );
  }

  void selectDate(DateTime date) {
    if (state is CalendarLoaded) {
      final currentState = state as CalendarLoaded;
      emit(currentState.copyWith(selectedDate: date));
    }
  }

  void changeMonth(int monthOffset) {
    if (state is CalendarLoaded) {
      final currentState = state as CalendarLoaded;
      final newMonth = DateTime(
        currentState.currentMonth.year,
        currentState.currentMonth.month + monthOffset,
      );
      emit(currentState.copyWith(currentMonth: newMonth));
    }
  }

  void addAppointment(Appointment appointment) {
    if (state is CalendarLoaded) {
      final currentState = state as CalendarLoaded;
      final updatedAppointments = [...currentState.appointments, appointment];
      emit(currentState.copyWith(appointments: updatedAppointments));
    }
  }

  void updateAppointment(String id, Appointment updatedAppointment) {
    if (state is CalendarLoaded) {
      final currentState = state as CalendarLoaded;
      final updatedAppointments = currentState.appointments.map((appointment) {
        return appointment.id == id ? updatedAppointment : appointment;
      }).toList();
      emit(currentState.copyWith(appointments: updatedAppointments));
    }
  }

  void deleteAppointment(String id) {
    if (state is CalendarLoaded) {
      final currentState = state as CalendarLoaded;
      final updatedAppointments = currentState.appointments
          .where((appointment) => appointment.id != id)
          .toList();
      emit(currentState.copyWith(appointments: updatedAppointments));
    }
  }

  List<Appointment> _generateSampleAppointments() {
    final now = DateTime.now();
    return [
      Appointment(
        id: '1',
        title: "Doctor's Appointment",
        dateTime: DateTime(now.year, now.month, now.day, 10, 0), // Bugün
        type: AppointmentType.doctor,
      ),
      Appointment(
        id: '2',
        title: "Ultrasound",
        dateTime: DateTime(now.year, now.month, now.day, 14, 0), // Bugün
        type: AppointmentType.ultrasound,
      ),
    ];
  }
}
