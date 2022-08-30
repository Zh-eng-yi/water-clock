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
  
  void _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(today.year - 5, today.month, today.day),
      lastDate: DateTime(today.year + 5, today.month, today.day),
    );
    if (picked != null) {
      if (isStart) {
        setState(() {
          startDate = picked;
        });
      } else {
        setState(() {
          endDate = picked;
        });
      }
    }
  }
  _showPickers() {
    showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(today.year - 5, today.month, today.day),
      lastDate: DateTime(today.year + 5, today.month, today.day),
    );
  }

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
                                        color:
                                            Color.fromARGB(255, 230, 104, 102),
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
                              ]
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  child: Text('${startDate.year}/${startDate.month}/${startDate.day}'),
                                  onPressed: () {
                                    // _showPickers();
                                    _selectDate(context, true);
                                  },
                                ),
                                const Text(' ~ '),
                                ElevatedButton(
                                  child: Text('End Date'),
                                  onPressed: () {},
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel')),
                                OutlinedButton(
                                    onPressed: () {},
                                    child: const Text('Reset')),
                                ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Save')),
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
