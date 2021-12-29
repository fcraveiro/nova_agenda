import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/services/constantes.dart';
import '/services/widgets.dart';
import 'package:toggle_switch/toggle_switch.dart';

/*
@override
void initState() {
  if (box.read('colunas') == null) {
    box.write('colunas', 2);
    log('Colunas Setup2 Vazio');
  }
  colunas = box.read('colunas');
  log('Colunas Setup2 $colunas');
}
*/

int colunas = 0;
late Color screenPickerColor;
late Color dialogPickerColor;
late Color dialogSelectColor;
Color pickerColor = const Color(0xff443a49);
Color currentColor = const Color(0xff443a49);
//Color cor = Colors.white;
Color cor = Colors.white;
Color cor1 = Colors.white;
Color cor2 = Colors.white;
Color cor3 = Colors.white;
Color cor4 = Colors.white;
String jose = '';
int josew = 0;
int value = 0;

class Setup extends StatefulWidget {
  const Setup({Key? key}) : super(key: key);

  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  @override
  void initState() {
    log('entrou');
    if (box.read('colunas') == null) {
      box.write('colunas', 2);
      log('Colunas 2 Vazio');
    }

    if (box.read('cor1') == null) {
      box.write('cor1', cor2.toString());
      log('Cor 1 Vazio');
    }
    if (box.read('cor2') == null) {
      box.write('cor2', cor2.toString());
      log('Cor 2 Vazio');
    }
    if (box.read('cor3') == null) {
      box.write('cor3', cor3.toString());
      log('Cor 3 Vazio');
    }
    if (box.read('cor4') == null) {
      box.write('cor4', cor4.toString());
      log('Cor 4 Vazio');
    }

    String cor = box.read('cor1'.toString());
    String valueString = cor.split('(0x')[1].split(')')[0]; // kind of hacky..
    value = int.parse(valueString, radix: 16);
    cor1 = Color(value).withOpacity(1);

    cor = box.read('cor2'.toString());
    valueString = cor.split('(0x')[1].split(')')[0]; // kind of hacky..
    value = int.parse(valueString, radix: 16);
    cor2 = Color(value).withOpacity(1);

    cor = box.read('cor3'.toString());
    valueString = cor.split('(0x')[1].split(')')[0]; // kind of hacky..
    value = int.parse(valueString, radix: 16);
    cor3 = Color(value).withOpacity(1);

    cor = box.read('cor4'.toString());
    valueString = cor.split('(0x')[1].split(')')[0]; // kind of hacky..
    value = int.parse(valueString, radix: 16);
    cor4 = Color(value).withOpacity(1);

//    jose = box.read('cor1'.toString());
//    log(jose.toString());
//    josew = int.parse(jose);

//    String valueString = jose.split('(0x')[1].split(')')[0]; // kind of hacky..
//    value = int.parse(valueString, radix: 16);

//    Color josew = (value);

/*


    cor2 = box.read('cor2');
    cor3 = box.read('cor3');
    cor4 = box.read('cor4');
*/
    colunas = box.read('colunas');
    log('Colunas Setup2 $colunas');
    setState(() {
      colunas = box.read('colunas');
    });

    screenPickerColor = Colors.blue; // Material blue.
    dialogPickerColor = Colors.red; // Material red.
    dialogSelectColor = const Color(0xFFA239CA); // A purple color

    super.initState();
  }

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  List<String> itens = [
    'Tema Claro/Escuro',
    'Cores da Agenda (Manhã) (Tarde) (Noite) (Madrugada)',
  ];
  List<FaIcon> itens2 = [
    const FaIcon(FontAwesomeIcons.lightbulb, size: 27, color: Colors.teal),
    const FaIcon(FontAwesomeIcons.search, size: 20),
  ];

  @override
  Widget build(BuildContext context) {
    colunas = box.read('colunas');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup2'),
        centerTitle: true,
        backgroundColor: cor1,
        elevation: 3,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 15),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 3,
              ),
              elevation: 0,
              color: const Color(0xFFD6D6D6),
              child: ListTile(
                title: txtro('Tema Claro/Escuro', 14, 4),
                trailing: GestureDetector(
                  onTap: () {
                    tema();
                  },
                  child: Container(
                    width: 150,
                    height: 30,
                    margin: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        FaIcon(FontAwesomeIcons.lightbulb,
                            size: 27, color: Colors.teal),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 3,
              ),
              elevation: 0,
              color: const Color(0xFFD6D6D6),
              child: ListTile(
                title: txtro('Numero de Colunas nas Fotos do Histórico', 14, 4),
                trailing: GestureDetector(
                  onTap: () {
//                    tema();
                  },
                  child: Container(
                    width: 150,
                    height: 30,
                    margin: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [fotosPorColuna(colunas)],
                    ),
                  ),
                ),
              ),
            ),
            // Cores da Agenda
            Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 3,
              ),
              elevation: 0,
              color: const Color(0xFFD6D6D6),
              child: ListTile(
                title: txtro('Cor Agenda Manhã/Tarde/Noite/Madrugada', 14, 4),
                trailing: Container(
                  width: 130,
                  height: 30,
                  margin: const EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          _showAddEventDialog(1);
                        },
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: cor1,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _showAddEventDialog(2);
                        },
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: cor2,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _showAddEventDialog(3);
                        },
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: cor3,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _showAddEventDialog(4);
                        },
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: cor4,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  fotosPorColuna(inicial) {
    return ToggleSwitch(
      minWidth: 35.0,
      minHeight: 90.0,
      fontSize: 16.0,
      initialLabelIndex: inicial - 1,
      activeBgColor: const [Colors.blue],
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey,
      inactiveFgColor: Colors.grey[900],
      totalSwitches: 4,
      labels: const ['1', '2', '3', '4'],
      onToggle: (index) {
        index = index + 1;
        setState(() {
          box.write('colunas', index);
          log('Gravado Colunas Setup2 $index');
        });
      },
    );
  }

  tema() {
    // ignore: avoid_print
    print('tema 2');
    ThemeService().switchTheme();
  }

  _showAddEventDialog(int tipo) async {
    log(tipo.toString());
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: BlockPicker(
            useInShowDialog: true,
            pickerColor: currentColor,
            onColorChanged: changeColor,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              setState(
                () => {
                  currentColor = pickerColor,
                  if (tipo == 1)
                    {
                      cor1 = currentColor,
                      box.write('cor1', currentColor.toString()),
                      log('1'),
                    }
                  else if (tipo == 2)
                    {
                      cor2 = currentColor,
                      box.write('cor2', currentColor.toString()),
                    }
                  else if (tipo == 3)
                    {
                      cor3 = currentColor,
                      box.write('cor3', currentColor.toString()),
                    }
                  else if (tipo == 4)
                    {
                      cor4 = currentColor,
                      box.write('cor4', currentColor.toString()),
                    }
                },
              );
              log(currentColor.toString());
              log('Picked ${pickerColor.toString()}');

              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
