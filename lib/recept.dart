import 'package:flutter/material.dart';

class ReceptScreen extends StatelessWidget {
  final String recept;
  ReceptScreen({required this.recept});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recept'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Expanded(
              child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(
                  'Recept:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  recept,
                  style: TextStyle(fontSize: 16),
                ),
                ],
              ),
              ),
            ),
            ],
        ),
        ) ); 
  }
}