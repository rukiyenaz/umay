import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gebelik_aapp/features/home/presentation/cubits/calendar_cubit.dart';
import 'package:gebelik_aapp/features/home/presentation/cubits/calendar_state.dart';
import '../widgets/appointment_dialog.dart';

class CalendarGrid extends StatelessWidget {
  final CalendarLoaded state;

  const CalendarGrid({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Week headers
          Row(
            children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                .map(
                  (day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          // Calendar grid
          _buildCalendarDays(context),
        ],
      ),
    );
  }

  Widget _buildCalendarDays(BuildContext context) {
    final firstDayOfMonth = DateTime(
      state.currentMonth.year,
      state.currentMonth.month,
      1,
    );
    final lastDayOfMonth = DateTime(
      state.currentMonth.year,
      state.currentMonth.month + 1,
      0,
    );
    final firstDayWeekday = firstDayOfMonth.weekday % 7;

    List<Widget> dayWidgets = [];

    // Empty cells for days before the first day of month
    for (int i = 0; i < firstDayWeekday; i++) {
      dayWidgets.add(const SizedBox());
    }

    // Days of the month
    for (int day = 1; day <= lastDayOfMonth.day; day++) {
      final date = DateTime(
        state.currentMonth.year,
        state.currentMonth.month,
        day,
      );
      final isSelected =
          date.day == state.selectedDate.day &&
          date.month == state.selectedDate.month &&
          date.year == state.selectedDate.year;

      // Check if date has appointments - YENİ
      final hasAppointments = state.appointments.any(
        (appointment) =>
            appointment.dateTime.day == date.day &&
            appointment.dateTime.month == date.month &&
            appointment.dateTime.year == date.year,
      );

      dayWidgets.add(
        GestureDetector(
          onTap: () {
            // Tarih seçimi
            context.read<CalendarCubit>().selectDate(date);
          },
          onDoubleTap: () {
            // YENİ
            // Çift tıklama ile randevu ekleme
            _showAddAppointmentDialog(context, date);
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: isSelected ? Colors.pink[200] : null,
              shape: BoxShape.circle,
            ),
            child: Stack(
              // Stack eklendi
              children: [
                Center(
                  child: Text(
                    day.toString(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
                // Appointment indicator - YENİ
                if (hasAppointments)
                  Positioned(
                    bottom: 2,
                    right: 8,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 7,
      physics: const NeverScrollableScrollPhysics(),
      children: dayWidgets,
    );
  }

  void _showAddAppointmentDialog(BuildContext context, DateTime selectedDate) {
    final cubit = context.read<CalendarCubit>();
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: cubit,
        child: AppointmentDialog(selectedDate: selectedDate),
      ),
    );
  }
}
