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
  late final DateTime defaultStart =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  late final DateTime defaultEnd =
      DateTime(today.year, today.month, today.day, 11, 59, 0);
  late DateTime selectedDateTime = defaultStart;
  late DateTime startDateTime = defaultStart;
  late DateTime endDateTime = defaultEnd;
  String eventName = '';
  String eventNote = '';

  void resetEvent() {
    startDateTime = defaultStart;
    endDateTime = defaultEnd;
    eventName = '';
    eventNote = '';
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: selectedDateTime,
        firstDate: DateTime(selectedDateTime.year - 5, selectedDateTime.month,
            selectedDateTime.day),
        lastDate: DateTime(selectedDateTime.year + 5, selectedDateTime.month,
            selectedDateTime.day),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: selectedDateTime.hour,
          minute: selectedDateTime.minute,
        ),
      );

  Future<DateTime?> pickDateAndTime() async {
    DateTime? date = await pickDate();
    if (date == null) return null;
    TimeOfDay? time = await pickTime();
    if (time == null) return null;
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  Future openDialog() {
    return showCupertinoDialog(
        context: context,
        builder: (context) => StatefulBuilder(
            builder: (context, setState) => SimpleDialog(
                  title: const Text('Add an event'),
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 120, top: 10),
                      child: TextFormField(
                        initialValue: eventName,
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
                        onChanged: (val) {
                          eventName = val;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: TextFormField(
                        initialValue: eventNote,
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
                        onChanged: (val) {
                          eventNote = val;
                        },
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
                            '${startDateTime.year}/${startDateTime.month}/${startDateTime.day} ${startDateTime.hour.toString().padLeft(2, '0')}:${startDateTime.minute.toString().padLeft(2, '0')}'),
                        onPressed: () async {
                          final DateTime? picked = await pickDateAndTime();
                          if (picked != null) {
                            setState(() {
                              startDateTime = picked;
                              if (startDateTime.compareTo(endDateTime) > 0) {
                                endDateTime = startDateTime;
                              }
                            });
                          }
                        },
                      ),
                      const Text(' ~ '),
                      ElevatedButton(
                        child: Text(
                            '${endDateTime.year}/${endDateTime.month}/${endDateTime.day} ${endDateTime.hour.toString().padLeft(2, '0')}:${endDateTime.minute.toString().padLeft(2, '0')}'),
                        onPressed: () async {
                          final DateTime? picked = await pickDateAndTime();
                          if (picked != null) {
                            setState(
                              () {
                                endDateTime = picked;
                              },
                            );
                          }
                        },
                      ),
                    ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')),
                          OutlinedButton(
                              onPressed: () {
                                setState((() {
                                  resetEvent();
                                }));
                              },
                              child: const Text('Reset')),
                          ElevatedButton(
                              onPressed: () {
                                resetEvent();
                              },
                              child: const Text('Save')),
                        ]),
                  ],
                )));
  }

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

// final DateTime? picked = await showDatePicker(
//   context: context,
//   initialDate: startDateTime,
//   firstDate:
//       DateTime(startDateTime.year - 5, startDateTime.month, startDateTime.day),
//   lastDate:
//       DateTime(startDateTime.year + 5, startDateTime.month, startDateTime.day),
// );
// if (picked != null) {
//   setState(() {
//     startDateTime = picked;
//     if (startDateTime.compareTo(endDateTime) > 0) {
//       endDateTime = startDateTime;
//     }
//   });
// }