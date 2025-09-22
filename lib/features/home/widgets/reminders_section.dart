import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gebelik_aapp/features/home/presentation/cubits/calendar_cubit.dart';
import 'package:gebelik_aapp/features/home/presentation/cubits/calendar_state.dart';
import 'appointment_card.dart';
import 'appointment_dialog.dart';

class RemindersSection extends StatelessWidget {
  final CalendarLoaded state;

  const RemindersSection({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedDateAppointments = state.appointments.where((appointment) {
      return appointment.dateTime.day == state.selectedDate.day &&
          appointment.dateTime.month == state.selectedDate.month &&
          appointment.dateTime.year == state.selectedDate.year;
    }).toList();

    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reminders for ${state.selectedDate.day}/${state.selectedDate.month}/${state.selectedDate.year}', // Yıl eklendi
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: () => _showAddAppointmentDialog(context),
                icon: const Icon(Icons.add, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (selectedDateAppointments.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  'No appointments for this day',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            ...selectedDateAppointments.map(
              (appointment) => AppointmentCard(appointment: appointment),
            ),
        ],
      ),
    );
  }

  void _showAddAppointmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<CalendarCubit>(),
        child: AppointmentDialog(selectedDate: state.selectedDate),
      ),
    );
  }
}
