import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gebelik_aapp/features/home/presentation/cubits/calendar_cubit.dart';
import 'package:gebelik_aapp/features/home/presentation/cubits/calendar_state.dart';
import 'package:gebelik_aapp/features/home/widgets/appointment_dialog.dart';
import 'package:gebelik_aapp/features/home/widgets/calendar_grid.dart';
import 'package:gebelik_aapp/features/home/widgets/calendar_header.dart';
import 'package:gebelik_aapp/features/home/widgets/reminders_section.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Calendar',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocBuilder<CalendarCubit, CalendarState>(
        builder: (context, state) {
          if (state is CalendarLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  CalendarHeader(state: state),
                  CalendarGrid(state: state),
                  RemindersSection(state: state),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddAppointmentDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddAppointmentDialog(BuildContext context) {
    final cubit = context.read<CalendarCubit>();
    final selectedDate = (cubit.state as CalendarLoaded).selectedDate;

    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: cubit,
        child: AppointmentDialog(selectedDate: selectedDate),
      ),
    );
  }
}
