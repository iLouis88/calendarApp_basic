import 'package:calendar_app/color_board.dart';
import 'package:calendar_app/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils.dart';

class AddEventWidget extends StatefulWidget {
  final Function(Event) onAddEvent;
  const AddEventWidget({super.key, required this.onAddEvent});

  @override
  State<AddEventWidget> createState() => _AddEventWidgetState();
}

class _AddEventWidgetState extends State<AddEventWidget> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  final List<String> _attendees = [];
  ColorPair _selectedColorPair = colorPairs[0];
  bool isEvent = false;
  final _urlController = TextEditingController();
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final Event newEvent = Event(
        title: _titleController.text,
        startTime: _startDate!,
        endTime: _endDate!,
        attendees: _attendees,
        leftColor: _selectedColorPair.leftColor,
        rightColor: _selectedColorPair.rightColor,
        url: _urlController.text,
        isEvent: isEvent,
      );
      widget.onAddEvent(newEvent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        FocusScope.of(context).unfocus();
        },
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            height: 55,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft:Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(2, 0.3),
                      color: Colors.grey
                  )
                ]
            ),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel', style: TextStyle(
                      color: Colors.red
                  ),),
                ),
                const Text('Add new reminder'),
                TextButton(onPressed: () => _submitForm(), child: Text('Save'),)
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin:  const EdgeInsets.only(left: 20, right:20 ),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                      //  const SizedBox(height: 50,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Event'),
                            Transform.scale(
                              scale: 0.8,
                              child: Switch(
                                value: isEvent,
                                onChanged: (value) {
                                  setState(() {
                                    isEvent = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),

                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                //border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(15)),
                            child: TextFormField(
                              controller: _titleController,
                              decoration: const InputDecoration(
                                  // labelText: 'Add title',
                                  hintText: 'Enter title',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w300,

                                  ),
                                  icon: Icon(Icons.edit_calendar),
                                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                                  enabledBorder:
                                      UnderlineInputBorder(borderSide: BorderSide.none)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                        if (isEvent == true)
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              //border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                            controller: TextEditingController(text: 'Demo'),
                            enabled: false,
                            decoration: const InputDecoration(
                                // labelText: 'Add title',
                                hintText: 'Enter event link',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w300,
                                ),
                                icon: Icon(Icons.link),
                                border: UnderlineInputBorder(borderSide: BorderSide.none),
                                enabledBorder:
                                    UnderlineInputBorder(borderSide: BorderSide.none)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox.shrink(),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(15)),
                          child: DropdownButtonFormField<ColorPair>(
                            value: _selectedColorPair,
                            items: colorPairs.map((ColorPair pair) {
                              return DropdownMenuItem(
                                value: pair,
                                child: Row(
                                  // Hiển thị mẫu màu trong menu
                                  children: <Widget>[
                                    Container(width: 20, height: 20, color: pair.leftColor),
                                    const SizedBox(width: 8),
                                    Container(
                                        width: 20, height: 20, color: pair.rightColor),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (ColorPair? newValue) {
                              setState(() {
                                if (newValue != null) {
                                  _selectedColorPair = newValue;
                                }
                              });
                            },
                            decoration: const InputDecoration(
                              icon: Icon(Icons.color_lens_rounded),
                              labelText: 'Select theme',
                              border: InputBorder.none, // Loại bỏ đường viền
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 1),
                          padding: const EdgeInsets.only(left: 10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              _startDate == null
                                  ? 'Pick a date'
                                  : DateFormat('yyyy-MM-dd').format(_startDate!),
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            trailing: const Icon(Icons.date_range_rounded),
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null && picked != _startDate) {
                                setState(() {
                                  _startDate = picked;
                                });
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 1),
                          padding: const EdgeInsets.only(left: 10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: ListTile(
                            title: Text(
                              _startDate == null
                                  ? 'Pick start time'
                                  : DateFormat('HH:mm').format(_startDate!),
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            trailing: const Icon(Icons.timer),
                            onTap: () async {
                              final TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (picked != null) {
                                setState(() {
                                  _startDate = DateTime(
                                    _startDate!.year,
                                    _startDate!.month,
                                    _startDate!.day,
                                    picked.hour,
                                    picked.minute,
                                  );
                                });
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 0),
                          padding: const EdgeInsets.only(left: 10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              _endDate == null
                                  ? 'Pick end time'
                                  : DateFormat('HH:mm').format(_endDate!),
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            trailing: const Icon(Icons.done_all),
                            onTap: () async {
                              final TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (picked != null) {
                                setState(() {
                                  _endDate = DateTime(
                                    _startDate!.year,
                                    _startDate!.month,
                                    _startDate!.day,
                                    picked.hour,
                                    picked.minute,
                                  );
                                });
                              }
                            }
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _submitForm();
                          },
                          child: const Text('Add Event'),
                        ),
                        const SizedBox(
                          height: 50,
                        ),

                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
