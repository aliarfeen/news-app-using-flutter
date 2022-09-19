import 'package:flutter/material.dart';

class OffLineScreen extends StatelessWidget {
  const OffLineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Image(image: AssetImage('assets/images/lost_connection.png')),
          SizedBox(
            height: 10,
          ),
          Text(
            'الاتصال بالشبكة مفقود',
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }
}
