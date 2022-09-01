import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<Appointment> events = [];
  final DateTime today = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  Future openDialog() => showCupertinoDialog(
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (context, setState) => SimpleDialog(
                title: const Text('Add an event'),
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 120, top: 10),
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
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8)),
                      onChanged: (val) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
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
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8)),
                      onChanged: (val) {},
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text('Start time'),
                        Text('End time'),
                      ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ElevatedButton(
                      child: Text(
                          '${startDate.year}/${startDate.month}/${startDate.day}'),
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: startDate,
                          firstDate:
                              DateTime(startDate.year - 5, startDate.month, startDate.day),
                          lastDate:
                              DateTime(startDate.year + 5, startDate.month, startDate.day),
                        );
                        if (picked != null) {
                          setState(() {
                            startDate = picked;
                            if (startDate.compareTo(endDate) > 0) {
                              endDate = startDate;
                            }
                          });
                        }
                      },
                    ),
                    const Text(' ~ '),
                    ElevatedButton(
                      child: Text(
                          '${endDate.year}/${endDate.month}/${endDate.day}'),
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: startDate,
                          firstDate:
                              DateTime(startDate.year, startDate.month, startDate.day),
                          lastDate:
                              DateTime(startDate.year + 5, startDate.month, startDate.day),
                        );
                        if (picked != null) {
                          setState(() {
                            endDate = picked;
                          });
                        }
                      },
                    ),
                  ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                            onPressed: () {
                              startDate = today;
                              endDate = today;
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                        OutlinedButton(
                            onPressed: () {
                              
                            },
                            child: const Text('Reset')),
                        ElevatedButton(
                            onPressed: () {},
                            child: const Text('Save')),
                      ]),
                ],
              )));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calendar'),
          actions: [
            IconButton(
              onPressed: () {
                openDialog();
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
        ));
  }
}

List<Appointment> getAppointments() {
  List<Appointment> events = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  events.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'class',
      color: Colors.blue));
  return events;
}

class EventsDataSource extends CalendarDataSource {
  EventsDataSource(List<Appointment> source) {
    appointments = source;
  }
}
