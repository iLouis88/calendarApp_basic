import 'package:calendar_app/main.dart';
import 'package:calendar_app/screens/calendar_screen.dart';
import 'package:calendar_app/utils.dart';
import 'package:flutter/material.dart';

import '../color_board.dart';
import '../models/event_model.dart';
import '../widgets/day_cell_widget.dart';
import '../widgets/addEvent_widget.dart';
import 'event_screen.dart';

class BigCalendarScreen extends StatefulWidget {
  const BigCalendarScreen({super.key});

  @override
  State<BigCalendarScreen> createState() => _BigCalendarScreenState();
}

class _BigCalendarScreenState extends State<BigCalendarScreen> {
  PageController _pageController = PageController();
  DateTime _selectedDate = DateTime.now();
  Map<DateTime, List<Event>> _events = {};
  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  List<DateTime> _generateDateForCurrentMoth(DateTime date) {
    final List<DateTime> dates = [];
    final int firstDayOfMonth = DateTime(date.year, date.month, 1).weekday;
    final int daysInMonth = DateUtils.getDaysInMonth(date.year, date.month);
    final int firstDayOfWeek = DateTime.sunday;

    final int daysBefore = (firstDayOfMonth - firstDayOfWeek) % 7;
    final DateTime firstDisplayedDate =
        DateTime(date.year, date.month, 1).subtract(Duration(days: daysBefore));

    for (int i = 0; i < daysBefore; i++) {
      dates.add(firstDisplayedDate.add(Duration(days: i)));
    }

    for (int i = 0; i < daysInMonth; i++) {
      dates.add(DateTime(date.year, date.month, i + 1));
    }

    final int totalDisplayedDays = daysBefore + daysInMonth;

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

  void _addEvent(DateTime selectedDate) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return AddEventWidget(
          onAddEvent: (event) {
            /* final List<Event> list = _events[selectedDate] ?? [];
            list.add(event);
            setState(() {
              _events[selectedDate] = list;
            });*/

            final List<Event> list2 = _events[event.startTime] ?? [];
            list2.add(event);
            setState(() {
              _events[event.startTime] = list2;
            });
            _selectedDate = event.startTime;

            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _showEventsSheet(DateTime date, List<Event> events) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.6,
          child: Container(
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.red,
                        )),
                    Text(
                      'Day event ${date.day}/${date.month}/${date.year}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          _addEvent(date);
                        },
                        icon: const Icon(
                          Icons.add_sharp,
                          color: Colors.blue,
                        )),
                  ],
                ),
                Expanded(
                  child: events.isEmpty
                      ? const Center(child: Text('There are no events'))
                      : ListView.builder(
                          itemCount: events.length,
                          itemBuilder: (context, index) {
                            final event = events[index];
                            return ListTile(
                              title: Text(event.title),
                              leading: event.isEvent
                                  ? const Icon(
                                      Icons.event,
                                      color: color1,
                                    )
                                  : const Icon(
                                      Icons.video_camera_front_rounded,
                                      color: color2,
                                    ),
                              onTap: event.isEvent
                                  ? () {
                                      customNavigator(
                                          context, const EventScreen());
                                    }
                                  : () {},
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

// Xác định ngày hôm nay
  DateTime _today = DateTime.now();

// Xử lý sự kiện khi nhấn vào nút "Today"
  void _handleTodayButtonPressed() {
    setState(() {
      // Thay đổi _selectedDate thành ngày hôm nay
      _selectedDate = _today;
    });
  }

  DateTime? _lastScrollTime;
  void _handleSwipe(DragUpdateDetails details) {
    DateTime now = DateTime.now();
    if (_lastScrollTime == null ||
        now.difference(_lastScrollTime!) > const Duration(seconds: 1)) {
      if (details.primaryDelta! < 0) {
        setState(() {
          _selectedDate = DateTime(
              _selectedDate.year, _selectedDate.month + 1, _selectedDate.day);
        });
      } else if (details.primaryDelta! > 0) {
        setState(() {
          _selectedDate = DateTime(
              _selectedDate.year, _selectedDate.month - 1, _selectedDate.day);
        });
      }
      _lastScrollTime = now;
    }
  }



  @override
  Widget build(BuildContext context) {
    final daysInMonth = _generateDateForCurrentMoth(_selectedDate);
    final List<Event> eventsForSelectedDate = _events[_selectedDate] ?? [];
    final mWidth = MediaQuery.of(context).size.width;
    return BasePage(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            if(mWidth < 600)
            IconButton(
                onPressed: () {
                  customNavigator(context, const CalendarScreen());
                },
                icon: const Icon(Icons.home)),
            const SizedBox.shrink(),
            Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 0.5),
                ),
                child: InkWell(
                    onTap: () {
                      _handleTodayButtonPressed();
                    },
                    child: const Text('Today'))),
            const Spacer(),
            Text(
              '${monthNames[_selectedDate.month - 1]} ${_selectedDate.year}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const Spacer(),
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
        body: Column(
          children: [
            Row(
              children: weekDays
                  .map((day) => Expanded(
                        child: Center(child: Text(day)),
                      ))
                  .toList(),
            ),
            Expanded(
              child: GestureDetector(
                onHorizontalDragUpdate: _handleSwipe,
                child: GridView.builder(
                  controller: _pageController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1 / 2,
                  ),
                  itemCount: daysInMonth.length,
                  itemBuilder: (context, index) {
                    final itemDate = daysInMonth[index];
                    List<Event> dayEvents = _events[itemDate] ?? [];
                    final bool isToday = isSameDay(itemDate, DateTime.now());
                    return DayCell(
                      date: itemDate,
                      events: dayEvents,
                      color: isSameDay(itemDate, _selectedDate)
                          ? const Color(0xFF0F4C81)
                          : isToday
                              ? color1
                              : Colors.white,
                      color2: isToday || isSameDay(itemDate, _selectedDate)
                          ? itemDate.month == _selectedDate.month
                              ? Colors.white
                              : Colors.grey[350]
                          : itemDate.month == _selectedDate.month
                              ? Colors.black
                              : Colors.grey[350],
                      onAddEvent: (selectedDate) {
                        setState(() {
                          _selectedDate = itemDate; // Cập nhật ngày được chọn
                        });
                        //  _addEvent(itemDate);
                        _showEventsSheet(itemDate, dayEvents);
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
