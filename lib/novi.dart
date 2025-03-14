import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  final Function(String, String) addTaskCallback;

  AddTaskScreen({required this.addTaskCallback});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _sastojak = TextEditingController();
  final TextEditingController _kolicina = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novi Sastojak'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _sastojak,
              decoration: InputDecoration(labelText: 'Sastojak'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _kolicina,
              decoration: InputDecoration(labelText: 'Kolicina'),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.addTaskCallback(_sastojak.text, _kolicina.text);
                Navigator.pop(context);
              },
              child: Text('Add Sastojak'),
            ),
          ],
        ),
      ),
    );
  }
}