import 'dart:html';
//import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  final bool showWeek;
  const Calendar({Key? key, required this.showWeek}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
            locale: 'it_IT',
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: DateTime.now(),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
            calendarFormat: widget.showWeek ? CalendarFormat.week : CalendarFormat.month,
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              defaultTextStyle: Theme.of(context).textTheme.bodyMedium!,
              todayTextStyle: Theme.of(context).textTheme.bodyMedium!,
              
              selectedTextStyle: Theme.of(context).textTheme.bodyMedium!,
              weekendTextStyle: Theme.of(context).textTheme.bodyMedium!,
              holidayTextStyle: Theme.of(context).textTheme.bodyMedium!,
            ),
            headerStyle: HeaderStyle(
              titleTextStyle: Theme.of(context).textTheme.bodyLarge!,
              formatButtonVisible: false,
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: Theme.of(context).textTheme.bodyMedium!,
              weekendStyle: Theme.of(context).textTheme.bodyMedium!,
            ),
          );
  }
}
