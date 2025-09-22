import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gebelik_aapp/features/home/domain/entities/appointment_model.dart';
import 'package:gebelik_aapp/features/home/presentation/cubits/calendar_cubit.dart';
import '../widgets/appointment_dialog.dart';

class DialogHelper {
  static void showEditAppointmentDialog(
    BuildContext context,
    Appointment appointment,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<CalendarCubit>(),
        child: AppointmentDialog(
          appointment: appointment,
          selectedDate: appointment.dateTime,
        ),
      ),
    );
  }

  static void showDeleteConfirmation(
    BuildContext context,
    Appointment appointment,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Appointment'),
        content: Text(
          'Are you sure you want to delete "${appointment.title}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              context.read<CalendarCubit>().deleteAppointment(appointment.id);
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
