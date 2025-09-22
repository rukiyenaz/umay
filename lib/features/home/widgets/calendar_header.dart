import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gebelik_aapp/features/home/presentation/cubits/calendar_cubit.dart';
import 'package:gebelik_aapp/features/home/presentation/cubits/calendar_state.dart';

class CalendarHeader extends StatelessWidget {
  final CalendarLoaded state;

  const CalendarHeader({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => context.read<CalendarCubit>().changeMonth(-1),
            icon: const Icon(Icons.chevron_left),
          ),
          Text(
            '${months[state.currentMonth.month - 1]} ${state.currentMonth.year}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          IconButton(
            onPressed: () => context.read<CalendarCubit>().changeMonth(1),
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
