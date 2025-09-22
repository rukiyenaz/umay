import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gebelik_aapp/features/home/domain/entities/appointment_model.dart';
import 'package:gebelik_aapp/features/home/domain/entities/appointment_type.dart';
import 'package:gebelik_aapp/features/home/presentation/cubits/calendar_cubit.dart';

class AppointmentDialog extends StatefulWidget {
  final Appointment? appointment;
  final DateTime selectedDate;

  const AppointmentDialog({
    Key? key,
    this.appointment,
    required this.selectedDate,
  }) : super(key: key);

  @override
  State<AppointmentDialog> createState() => _AppointmentDialogState();
}

class _AppointmentDialogState extends State<AppointmentDialog> {
  late TextEditingController _titleController;
  late DateTime _selectedDateTime;
  late AppointmentType _selectedType;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.appointment?.title ?? '',
    );
    _selectedDateTime =
        widget.appointment?.dateTime ??
        DateTime(
          widget.selectedDate.year,
          widget.selectedDate.month,
          widget.selectedDate.day,
          10,
          0,
        );
    _selectedType = widget.appointment?.type ?? AppointmentType.other;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.appointment == null ? 'Add Appointment' : 'Edit Appointment',
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<AppointmentType>(
            value: _selectedType,
            decoration: const InputDecoration(
              labelText: 'Type',
              border: OutlineInputBorder(),
            ),
            items: AppointmentType.values.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Row(
                  children: [
                    Icon(type.icon, color: type.color, size: 20),
                    const SizedBox(width: 8),
                    Text(type.name.toUpperCase()),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedType = value!;
              });
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _selectedDateTime,
                      firstDate: DateTime.now().subtract(
                        const Duration(days: 365),
                      ),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      setState(() {
                        _selectedDateTime = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          _selectedDateTime.hour,
                          _selectedDateTime.minute,
                        );
                      });
                    }
                  },
                  child: Text(
                    '${_selectedDateTime.day}/${_selectedDateTime.month}/${_selectedDateTime.year}',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
                    );
                    if (time != null) {
                      setState(() {
                        _selectedDateTime = DateTime(
                          _selectedDateTime.year,
                          _selectedDateTime.month,
                          _selectedDateTime.day,
                          time.hour,
                          time.minute,
                        );
                      });
                    }
                  },
                  child: Text(
                    '${_selectedDateTime.hour.toString().padLeft(2, '0')}:${_selectedDateTime.minute.toString().padLeft(2, '0')}',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_titleController.text.trim().isNotEmpty) {
              final appointment = Appointment(
                id:
                    widget.appointment?.id ??
                    DateTime.now().millisecondsSinceEpoch.toString(),
                title: _titleController.text.trim(),
                dateTime: _selectedDateTime,
                type: _selectedType,
              );

              final cubit = context.read<CalendarCubit>();
              if (widget.appointment == null) {
                cubit.addAppointment(appointment);
              } else {
                cubit.updateAppointment(widget.appointment!.id, appointment);
              }

              Navigator.of(context).pop(appointment);
            }
          },
          child: Text(widget.appointment == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }
}
