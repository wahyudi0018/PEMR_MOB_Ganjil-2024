import 'dart:async';
import 'package:flutter/material.dart';
import 'basic_widgets/image_widget.dart';
import 'basic_widgets/text_widget.dart';
import 'basic_widgets/loading_cupertino.dart';
import 'basic_widgets/fab_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Hello World'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const MyImageWidget(),
              const SizedBox(height: 20.0),
              const MyTextWidget(),
              const SizedBox(height: 20.0),
              MyLoadingCupertino(),
              Text("${selectedDate.toLocal()}".split(' ')[0]),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _selectDate(context);
                  print(selectedDate.day + selectedDate.month + selectedDate.year);
                },
                child: const Text('Pilih Tanggal'),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                child: const Text('Show alert'),
                onPressed: () {
                  showAlertDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: MyFabWidget(),
    );
  }
}

showAlertDialog(BuildContext context) {
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    title: const Text("My title"),
    content: const Text("This is my message."),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
