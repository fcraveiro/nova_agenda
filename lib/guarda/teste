import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List> _eventsList = {};
  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  DateTime teste28 = DateTime(2001, 12, 28);
  DateTime teste29 = DateTime(2001, 12, 29);
  DateTime teste30 = DateTime(2001, 12, 30);
  DateTime teste31 = DateTime(2001, 12, 31);

  @override
  void initState() {
    super.initState();
//    log(teste31.toString());
    _selectedDay = _focusedDay;
    _eventsList = {
      teste28: ['Event A6', 'Event B6'],
//      DateTime.now(): ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      teste29: ['Event A8', 'Event B8', 'Event C8', 'Event D8'],
      teste30: ['Meu   A1', 'Meu   B1', 'Meu   C1', 'Meu   D1'],
      teste29: ['Event A10', 'Event B10', 'Event C10'],
      teste30: ['Event A11', 'Event B11'],
      teste30: ['Event A12', 'Event B12', 'Event C12', 'Event D12'],
      teste31: ['Event A13', 'Event B13'],
      teste31: ['Event A14', 'Event B14', 'Event C14'],
    };
  }

  @override
  Widget build(BuildContext context) {
    final _events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_eventsList);

    List _getEventForDay(DateTime day) {
      return _events[day] ?? [];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('calendar sample'),
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: 'pt_BR',
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            eventLoader: _getEventForDay,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                _getEventForDay(selectedDay);
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          ListView(
            shrinkWrap: true,
            children: _getEventForDay(_selectedDay!)
                .map((event) => ListTile(
                      title: Text(event.toString()),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
