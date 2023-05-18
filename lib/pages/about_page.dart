import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 72, 196),
        elevation: 0,
        title: Text(
          'A B O U T',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Center(
        child: Text('this aap is desgined for....'),
      ),
    );
  }
}
