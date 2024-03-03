import 'package:calendar_app/color_board.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            
            const CircleAvatar(
              backgroundImage: NetworkImage('https://i.imgur.com/C1vvUz5.jpeg'),
              radius: 40,
            ),
            const SizedBox(
              height: 10,
            ),
            const  Text('Mr. Louis',style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),),
            const SizedBox(
              height: 5,
            ),
            const  Text('Flutter Developer', style: TextStyle(
              fontStyle: FontStyle.italic
            ),),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 90,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Follow',
                    style: TextStyle(
                      color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 90,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Message',
                    style: TextStyle(
                        color: Colors.black54
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 40,
              margin: const EdgeInsets.only(bottom: 1),
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5)
                )
              ),
              child: const Row(
                children: [
                  Icon(Icons.home),
                  const SizedBox(width: 10,),
                  Text('Overview'),
                ],
              ),
            ),

            Container(
              height: 40,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 1),
              decoration: const BoxDecoration(
                  color: Colors.white,

              ),
              child: const Row(
                children: [
                  Icon(Icons.supervised_user_circle),
                   SizedBox(width: 10,),
                  Text('About me'),
                ],
              ),
            ),

            Container(
              height: 40,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 1),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5)
                  )
              ),
              child: const Row(children: [
                  Icon(Icons.help),
                   SizedBox(width: 10,),
                  Text('Help'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
