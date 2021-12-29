import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Colorido extends StatefulWidget {
  const Colorido({Key? key}) : super(key: key);

  @override
  _ColoridoState createState() => _ColoridoState();
}

class _ColoridoState extends State<Colorido> {
// create some values
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);
  Color teste = Colors.amber;

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('aa'),
          backgroundColor: teste,
        ),
        body: SafeArea(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: _showAddEventDialog, child: const Text('a'))
            ],
          ),
        ));
  }

  _showAddEventDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
/*
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,
          ),

          child: MaterialPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,
            enableLabel: true,
          ),
*/

          child: BlockPicker(
            useInShowDialog: true,
            pickerColor: currentColor,
            onColorChanged: changeColor,
          ),
//           child: MultipleChoiceBlockPicker(
//             pickerColors: currentColors,
//             onColorsChanged: changeColors,
//           ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Got it'),
            onPressed: () {
              setState(
                () => {
                  teste = pickerColor,
                  currentColor = pickerColor,
                },
              );
              log(currentColor.toString());
              log(pickerColor.toString());

              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
