//  Copyright (c) 2019 Aleksander Woźniak
//  Licensed under Apache License v2.0

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Table Calendar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Table Calendar Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _selectedDay;
  Map<DateTime, List> _events;
  List _selectedEvents;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDay = DateTime(now.year, now.month, now.day);
    _events = {
      DateTime(2019, 2, 22): ['Event A', 'Event B', 'Event C'],
      DateTime(2019, 2, 23): ['Event A'],
      DateTime(2019, 2, 24): ['Event B', 'Event C'],
      DateTime(2019, 3, 1): ['Event A', 'Event B', 'Event C', 'Event D', 'Event E', 'Event F', 'Event G'],
      DateTime(2019, 1, 29): Set.from(['Event A', 'Event A', 'Event B']).toList(),
      DateTime(2019, 1, 30): ['Event A', 'Event A', 'Event B'],
    };
    _selectedEvents = _events[_selectedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTableCalendar(),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  // Configure the calendar here
  Widget _buildTableCalendar() {
    return TableCalendar(
      selectedColor: Colors.deepOrange[400],
      todayColor: Colors.deepOrange[200],
      eventMarkerColor: Colors.brown[700],
      calendarFormat: CalendarFormat.week,
      formatToggleVisible: true,
      centerHeaderTitle: false,
      events: _events,
      onDaySelected: (day) {
        setState(() {
          _selectedDay = day;
          _selectedEvents = _events[_selectedDay] ?? [];
        });
      },
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString()),
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }
}
