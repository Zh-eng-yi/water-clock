import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_clock/event_editing_page.dart';
import 'event_detail_page.dart';
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
      DateTime(today.year, today.month, today.day, 23, 59, 0);
  late DateTime startDateTime = defaultStart;
  late DateTime endDateTime = defaultEnd;
  TextEditingController nameController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void resetEvent() {
    startDateTime = defaultStart;
    endDateTime = defaultEnd;
    nameController.clear();
    noteController.clear();
  }

  Future<DateTime?> pickDate(bool isStart) {
    if (isStart) {
      return showDatePicker(
        context: context,
        initialDate: startDateTime,
        firstDate: DateTime(
            defaultStart.year - 5, defaultStart.month, defaultStart.day),
        lastDate: DateTime(
            defaultStart.year + 5, defaultStart.month, defaultStart.day),
      );
    } else {
      return showDatePicker(
        context: context,
        initialDate: endDateTime,
        firstDate: DateTime(
            startDateTime.year, startDateTime.month, startDateTime.day),
        lastDate: DateTime(
            defaultStart.year + 5, defaultStart.month, defaultStart.day),
      );
    }
  }

  Future<TimeOfDay?> pickTime(bool isStart) {
    DateTime date = isStart ? startDateTime : endDateTime;
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: date.hour,
        minute: date.minute,
      ),
    );
  }

  Future<DateTime?> pickDateAndTime(bool isStart) async {
    DateTime? date = await pickDate(isStart);
    if (date == null) return null;
    TimeOfDay? time = await pickTime(isStart);
    if (time == null) return null;
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  Future addEventDialog() {
    return showCupertinoDialog(
        context: context,
        builder: (context) => StatefulBuilder(
            builder: (context, setState) => SimpleDialog(
                  title: const Text('Add an event'),
                  children: <Widget>[
                    Form(
                        key: _formKey,
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 10),
                            child: TextFormField(
                              validator: (value) {
                                if (nameController.text.isEmpty) {
                                  return "Required field";
                                } else {
                                  return null;
                                }
                              },
                              controller: nameController,
                              decoration: const InputDecoration(
                                  labelText: 'Event name',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors
                                          .grey, //fromARGB(255, 230, 104, 102),
                                      width: 1,
                                    ),
                                  ),
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            child: TextFormField(
                              controller: noteController,
                              decoration: const InputDecoration(
                                  labelText: 'Event Description',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors
                                          .grey, //fromARGB(255, 230, 104, 102),
                                      width: 1,
                                    ),
                                  ),
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10)),
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text('Start time'),
                                Text('End time'),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 110,
                                  height: 45,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final DateTime? picked =
                                          await pickDateAndTime(true);
                                      if (picked != null) {
                                        setState(() {
                                          startDateTime = picked;
                                          if (startDateTime
                                                  .compareTo(endDateTime) >
                                              0) {
                                            endDateTime = startDateTime;
                                          }
                                        });
                                      }
                                    },
                                    child: Text(
                                      '${startDateTime.year}/${startDateTime.month}/${startDateTime.day} ${startDateTime.hour.toString().padLeft(2, '0')}:${startDateTime.minute.toString().padLeft(2, '0')}',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                const Text(' ~ '),
                                SizedBox(
                                  width: 110,
                                  height: 45,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final DateTime? picked =
                                          await pickDateAndTime(false);
                                      if (picked != null) {
                                        setState(
                                          () {
                                            endDateTime = picked;
                                          },
                                        );
                                      }
                                    },
                                    child: Text(
                                      '${endDateTime.year}/${endDateTime.month}/${endDateTime.day} ${endDateTime.hour.toString().padLeft(2, '0')}:${endDateTime.minute.toString().padLeft(2, '0')}',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ]),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                        if (!_formKey.currentState!
                                            .validate()) {
                                        } else if (startDateTime
                                                .compareTo(endDateTime) >
                                            0) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Error. Event end time prior to the start time.')));
                                        } else {
                                          events.add(Appointment(
                                            startTime: startDateTime,
                                            endTime: endDateTime,
                                            subject: nameController.text,
                                          ));
                                          resetEvent();
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: const Text('Save')),
                                ]),
                          )
                        ]))
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
                // addEventDialog();
                showDialog(context: context, builder: (_) => const EventEditingPage());
              },
              icon: const Icon(Icons.add_task_rounded),
              iconSize: 30,
            )
          ],
        ),
        body: SfCalendar(
          view: CalendarView.week,
          dataSource: EventsDataSource(events),
          onTap: (details) {
            if (details.appointments == null) return;
            final event = details.appointments!.first;
          },
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