import 'package:calendar_app/screens/event_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../color_board.dart';
import '../models/event_model.dart';
import '../screens/profile_screen.dart';
import '../utils.dart';
class EventDisplay extends StatelessWidget {
  const EventDisplay({
    super.key,
    required this.eventsForSelectedDate,
  });

  final List<Event> eventsForSelectedDate;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: eventsForSelectedDate.length,
      itemBuilder: (context, index) {
        final event = eventsForSelectedDate[index];
        return InkWell(
          onTap:(){
            FocusScope.of(context).unfocus();

          },

          child:  InkWell(
            onTap: event.isEvent ?  (){
              customNavigator(context, const EventScreen());
            } : (){},
            child: Container(
              margin: const EdgeInsets.fromLTRB(18, 10, 18, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    20), // Đặt bán kính cong cho viền
                color: event.leftColor, // Màu nền chính của Container
              ),
              child: Row(
                children: [
                  Container(
                    width: 10, // Chiều rộng của phần màu sắc bên trái
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      color: Colors.blue, // Màu của thanh bên trái
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 2),
                      decoration:  BoxDecoration(
                          color: event.rightColor, //event.background
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(3),
                              bottomLeft: Radius.circular(3),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: color2,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '${DateFormat('HH:mm').format(event.startTime)} - ${DateFormat('HH:mm').format(event.endTime)}',
                                  style: const TextStyle(
                                    color: color1,
                                  ),
                                ),
                                // Text(event.attendees.join(', ')),

                                const SizedBox(height: 5),
                                if(event.isEvent == false)
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      backgroundImage: NetworkImage('https://i.imgur.com/C1vvUz5.jpeg'),
                                      radius: 17,
                                    ),
                                    const SizedBox(width: 10),
                                    TextButton(
                                      onPressed: () {
                                        // Thêm hành động khi nhấn vào nút
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: const Size(50,
                                            30), // Cỡ tối thiểu của nút
                                        tapTargetSize: MaterialTapTargetSize
                                            .shrinkWrap, // Loại bỏ padding mặc định
                                        alignment: Alignment.centerLeft,
                                      ),
                                      child: InkWell(
                                        onTap: (){
                                          customNavigator(context, const ProfileScreen());
                                        },
                                        child: const Text(
                                          'View Client Profile',
                                          style: TextStyle(
                                            color:
                                            Colors.blue, // Màu của chữ
                                          ),
                                        ),
                                      )
                                    ),
                                  ],
                                ),
                                const SizedBox.shrink(),
                              ],
                            ),

                            // icon
                            if(event.isEvent == false)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                  color2, // Màu nền của container hình tròn
                                ),
                                child: const Icon(
                                  Icons
                                      .video_camera_back_rounded, // Biểu tượng email hoặc bất kỳ biểu tượng nào bạn muốn
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

