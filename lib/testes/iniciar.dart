// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

final List<String> countries = [
  'United Kingdom',
  'USA',
  'Frances',
  'Australia',
  'Germany',
  'India',
  'Vietnam'
];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AlertDialogs'),
        ),
        body: Center(
            child: ListView(
          children: ListTile.divideTiles(tiles: [
            ListTile(
              title: const Text('AlertDialog'),
              onTap: () => _showMessageDialog(context),
            ),
            ListTile(
                title: const Text('TextField Dialog'),
                onTap: () => _showAddNoteDialog(context))
          ], context: context)
              .toList(),
        )));
  }

  _showMessageDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to delete all items'),
            actions: [
              FlatButton(
                child: const Text('Yes'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ));

  _showAddNoteDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add your note"),
            content: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          hintText: 'Enter your note',
                          icon: Icon(Icons.note_add)),
                    )
                  ],
                ),
              ),
            ),
            actions: [
              FlatButton(
                child: const Text("Yes"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
}
