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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calendar'),
          actions: [
            IconButton(
              onPressed: () {
                showCupertinoDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                          title: const Text('Add an event'),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, right: 120, top: 10),
                              child: TextField(
                                decoration: const InputDecoration(
                                    labelText: 'Event name',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 230, 104, 102),
                                        width: 1,
                                      ),
                                    ),
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10)),
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
                                        color:
                                            Color.fromARGB(255, 230, 104, 102),
                                        width: 1,
                                      ),
                                    ),
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10)),
                                onChanged: (val) {},
                              ),
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  child: Text('Start Date'),
                                  onPressed: () {
                                    
                                  },
                                ),
                                ElevatedButton(
                                  child: Text('End Date'),
                                  onPressed: () {
                                    
                                  },
                                ),
                              ]
                            ),
                            // SfDateRangePicker(
                            //   // onSelectionChanged: ,
                            //   selectionMode:
                            //       DateRangePickerSelectionMode.multiple,
                            //   initialSelectedDate: DateTime.now(),
                            // ),

                            // SizedBox(
                            //   height: 150,
                            //   width: 10,
                            //   child: CupertinoDatePicker(
                            //     initialDateTime: DateTime.now(),
                            //     onDateTimeChanged:(dateTime) {
                            //     // DateTime current = DateTime.now();
                            //       setState(() {

                            //       });
                            //     },
                            //   ),
                            // ),
                            Row(children: [
                              const Spacer(),
                              OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel')),
                              const Spacer(),
                              ElevatedButton(
                                  onPressed: () {}, child: const Text('Save')),
                              const Spacer(),
                            ]),
                          ],
                        ));
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
