import 'package:calendar_app/color_board.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event online'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tuesday, 19 March',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
              'The Evolving Use Cases of AI for Cybersecurity in Vietnam’s AI Landscape',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text('Vietnam Standard Time 8:00 AM - 11:10 AM (GMT+07:00)'),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Location',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            const ListTile(
              title: Text('Sofitel Saigon Plaza'),
              leading: Icon(Icons.location_on),
              subtitle: Text(
                  '17 Đường Lê Duẩn Bến Nghé, Thành phố Hồ Chí Minh 700000'),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'Agenda',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomContainer(
              color: color4,
              text: '8:00',
              text2: 'Registration and Breakfast',
            ),
            const CustomContainer(
              color: color2,
              text: '8:55',
              text2: 'Group Photograph (Yes, we will share this)',
            ),
            const CustomContainer(
              color: color4,
              text: '9:00',
              text2: 'Opening Remarks',
            ),
            const CustomContainer(
              color: color4,
              text: '10:00',
              text2: 'Technology Insight',
            ),
            const CustomContainer(
              color: color2,
              text: '11:30',
              text2: 'End of OpenGov Breakfast Insight',
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'About this event',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            const Row(
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.timelapse_outlined),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '3 hours 10 minutes',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),
                Spacer(),
                Icon(Icons.phone_android),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Moibile e ticket ',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Safeguarding Generative AI to Become an AI-Ready Organisation',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              content,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'About the organiser',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://i.imgur.com/TpBVk31.jpeg'),
                      radius: 30,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Organised by',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'OpenGov Asia',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '2.1k Followers',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: 80,
                  child: const Text(
                    'Contact',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    'Follow',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      )),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final String text;
  final String text2;
  final Color color;
  const CustomContainer({
    super.key,
    required this.text,
    required this.text2,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: color,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[300],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Text(text2,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
