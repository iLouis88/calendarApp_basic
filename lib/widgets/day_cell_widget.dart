  import 'package:flutter/material.dart';

  import '../color_board.dart';
  import '../models/event_model.dart';

  class DayCell extends StatelessWidget {
    final DateTime date;
    final List<Event> events;
    final Function(DateTime) onAddEvent;
    final Color color;
    final Color? color2;

    const DayCell(
        {Key? key,
        required this.date,
        required this.events,
        required this.onAddEvent,
        required this.color,
          required this.color2,
        })
        : super(key: key);

    @override
    Widget build(BuildContext context) {
      return InkWell(
        onTap: () => onAddEvent(date),
        child: Container(
          margin: const EdgeInsets.all(4.0),
        // padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(8.0),
            color: color,
          ),
          child: Column(
            children: [
              Text('${date.day}',
                  style:  TextStyle(fontWeight: FontWeight.bold, color: color2 )),
              ...events.map((e) => Container(
                margin: const EdgeInsets.only(bottom: 3),
                padding: const EdgeInsets.fromLTRB(3,0,3,0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: e.rightColor,

                  ),
                  child: Text(e.title,
                  maxLines: 1,
                    style:  TextStyle(
                      fontSize: 10,
                      color: e.leftColor
                    ),
                  ))).toList(),
            ],
          ),
        ),
      );
    }
  }
