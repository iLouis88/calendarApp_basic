import 'package:calendar_app/models/event_model.dart';
import 'package:calendar_app/screens/big_calendar_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../color_board.dart';
import '../utils.dart';
import '../widgets/event_display.dart';
import '../widgets/addEvent_widget.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();

  Map<DateTime, List<Event>> _events = {};

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void _addEvent() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return AddEventWidget(
          onAddEvent: (event) {
            final List<Event> list = _events[_selectedDate] ?? [];
            list.add(event);
            setState(() {
              _events[_selectedDate] = list;
            });
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  List<DateTime> _generateDateForCurrentMonth(DateTime date) {
    final List<DateTime> dates = [];
    final int firstDayOfMonth = DateTime(date.year, date.month, 1).weekday;
    final int daysInMonth = DateUtils.getDaysInMonth(date.year, date.month);

    // Add previous month's trailing days
    const int firstDayOfWeek = DateTime
        .sunday; // Hoặc DateTime.monday tùy vào bạn muốn tuần bắt đầu từ ngày nào
    final int daysBefore = (firstDayOfMonth - firstDayOfWeek) % 7;
    final DateTime firstDisplayedDate =
        DateTime(date.year, date.month, 1).subtract(Duration(days: daysBefore));

    for (int i = 0; i < daysBefore; i++) {
      dates.add(firstDisplayedDate.add(Duration(days: i)));
    }

// Add current month's days
    for (int i = 0; i < daysInMonth; i++) {
      dates.add(DateTime(date.year, date.month, i + 1));
    }

// Add next month's leading days to fill the grid
    final int totalDisplayedDays =
        daysBefore + daysInMonth; // Total days displayed in the grid
    final int nextMonthDays = totalDisplayedDays % 7 == 0
        ? 0
        : 7 -
            (totalDisplayedDays %
                7); // Calculate remaining days to fill the last week
    for (int i = 0; i < nextMonthDays; i++) {
      dates.add(DateTime(date.year, date.month, daysInMonth + i + 1));
    }

    return dates;
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = _generateDateForCurrentMonth(_selectedDate);
    final List<Event> eventsForSelectedDate = _events[_selectedDate] ?? [];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '${monthNames[_selectedDate.month]} ${_selectedDate.year}',
          style: const TextStyle(color: color2, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BigCalendarScreen()));
              },
              icon: const Icon(Icons.change_circle_outlined)),
          IconButton(
            onPressed: _addEvent,
            icon: const Icon(Icons.add),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              setState(() {
                _selectedDate = DateTime(_selectedDate.year,
                    _selectedDate.month - 1, _selectedDate.day);
                // Also reset events for new month
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              setState(() {
                _selectedDate = DateTime(_selectedDate.year,
                    _selectedDate.month + 1, _selectedDate.day);
                // Also reset events for new month
              });
            },
          ),
        ],
      ),
      body: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Column(
          children: [
            Row(
              children: weekDays
                  .map((day) => Expanded(child: Center(child: Text(day))))
                  .toList(),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                ),
                itemCount: daysInMonth.length,
                itemBuilder: (context, index) {
                  final itemDate = daysInMonth[index];
                  final bool isToday = isSameDay(itemDate, DateTime.now());
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedDate = itemDate; // Update selected date
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        /* boxShadow: isToday || isSameDay(itemDate, _selectedDate) ? [ // Nếu là ngày hôm nay hoặc là ngày được chọn
                        BoxShadow(
                          blurRadius: 2.4,
                          offset: Offset(1, 0),
                        ),
                      ] : [],*/
                        color: isSameDay(itemDate, _selectedDate)
                            ? const Color(0xFF0F4C81)
                            : isToday
                                ? color1
                                : Colors.white,
                      ),
                      child: Text('${itemDate.day}',
                          style: TextStyle(
                            color: isToday || isSameDay(itemDate, _selectedDate)
                                ? itemDate.month == _selectedDate.month
                                    ? Colors.white
                                    : Colors.grey[350]
                                : itemDate.month == _selectedDate.month
                                    ? Colors.black
                                    : Colors.grey[350],
                          )),
                    ),
                  );
                },
              ),
            ),
            const Row(children: [
              SizedBox(
                width: 15,
              ),
              Text(
                'Upcoming Events',
                style: TextStyle(
                    fontWeight: FontWeight.w800, color: color2, fontSize: 16),
              ),
            ]),
            Expanded(
              child: eventsForSelectedDate.isEmpty
                  ? const Center(
                      child: Text(
                          'No events for this day')) // Show this when there are no events
                  : EventDisplay(eventsForSelectedDate: eventsForSelectedDate),
            ),
          ],
        ),
      ),
    );
  }
}
