import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<Appointment> events = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) =>  SimpleDialog(
                  title: const Text('Add an event'),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 120, top: 10),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Event name',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 230, 104, 102),
                              width: 1,
                            ),
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10)
                        ),
                        onChanged: (val) {
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Event Description',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 230, 104, 102),
                              width: 1,
                            ),
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10)
                        ),
                        onChanged: (val) {
                        },
                      ),
                    ),
                    SizedBox(
                      height: 180,
                      child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged:(dateTime) {
                        // DateTime current = DateTime.now();
                          setState(() {
                          
                          });
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                      
                      },
                      icon: Icon(Icons.add)
                    ),
                  ],
                )
              );
            },
            // Design an more graceful add icon.
            icon: const Icon(Icons.add_task_rounded),
            iconSize: 30,
          )
        ],
      ),
      body: SfCalendar(
        view: CalendarView.schedule,
        dataSource: EventsDataSource(events),
      )
    );
  }
}

List<Appointment> getAppointments() {
  List<Appointment> events = <Appointment> [];
  final DateTime today = DateTime.now();
  final DateTime startTime = DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  events.add(
    Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'class',
      color: Colors.blue
  ));
  return events;
}

class EventsDataSource extends CalendarDataSource {
  EventsDataSource(List<Appointment> source) {
    appointments = source;
  }
}