import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'event.dart';
import 'utils.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;

  const EventEditingPage({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  State<EventEditingPage> createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  late DateTime fromDate;
  late DateTime toDate;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController detailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(const Duration(hours: 2));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: <Widget>[
        Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 5, top: 10, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Create an event',
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            )),
        Form(
            key: _formKey,
            child: Column(
              children: [
                nameField(),
                detailField(),
                // selectTime(),
                timePicker(),

              ],
            )),
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 25),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            SizedBox(
                width: 100,
                height: 45,
                child: OutlinedButton(
                    onPressed: () {}, child: const Text('Reset'))),
            SizedBox(
                width: 100,
                height: 45,
                child: ElevatedButton(
                    onPressed: () {}, child: const Text('Save'))),
          ]),
        )
      ],
    );
  }

  Widget nameField() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextFormField(
          controller: nameController,
          validator: (name) => name != null && name.isEmpty ? "Please enter an event name" : null,
          decoration: const InputDecoration(
              labelText: 'Event name',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
        ),
      );

  Widget detailField() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: TextFormField(
          decoration: const InputDecoration(
              labelText: 'Event details',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
        ),
      );

  Widget selectTime() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text('From'),
                SizedBox(
                  width: 110,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('From'),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text('To'),
                SizedBox(
                  width: 110,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('To'),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget timePicker() => Column(
    children: [
      startTimePicker(),
    ],
  );

  Widget startTimePicker() => Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Row(
    children: [
      Expanded(
        child: dropdownField(
          text: Utils.toDate(fromDate),
          onClicked: () {},
        ),
      ),
      Expanded(
        child: dropdownField(
          text: Utils.toTime(fromDate),
          onClicked: () {}, 
        ),
      ),
    ],
  ));

  Widget dropdownField({
    required String text,
    required VoidCallback onClicked,
  }) => ListTile(
    title: Text(text),
    trailing: Icon(Icons.arrow_drop_down),
    onTap: onClicked,
  );
}
