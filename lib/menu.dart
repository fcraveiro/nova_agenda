import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:nova_agenda/paginas/addpacientes.dart';
import 'package:nova_agenda/paginas/agendapacientes.dart';
import 'package:nova_agenda/paginas/pacientes.dart';
import 'package:nova_agenda/paginas/setup.dart';
import 'package:nova_agenda/services/constantes.dart';
import 'package:nova_agenda/testes/appbar1.dart';
import '/services/widgets.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

int colunas = 0;
Color cor = Colors.grey;
Color corDaManha = Colors.grey;
Color corDaTarde = Colors.grey;
Color corDaNoite = Colors.grey;
Color corDaMadrugada = Colors.grey;
Color corDoMarker = Colors.grey;
Color corSelected = Colors.grey;
Color corHoje = Colors.grey;

class _MenuState extends State<Menu> {
  @override
  void initState() {
    log('entrou');
    if (box.read('colunas') == null) {
      box.write('colunas', 2);
      log('Colunas 2 Vazio');
    }
    if (box.read('corDaManha') == null) {
      box.write('corDaManha', corDaTarde.toString());
      log('Cor 1 Vazio');
    }
    if (box.read('corDaTarde') == null) {
      box.write('corDaTarde', corDaTarde.toString());
      log('Cor 2 Vazio');
    }
    if (box.read('corDaNoite') == null) {
      box.write('corDaNoite', corDaNoite.toString());
      log('Cor 3 Vazio');
    }
    if (box.read('corDaMadrugada') == null) {
      box.write('corDaMadrugada', corDaMadrugada.toString());
      log('Cor corDaMadrugada Vazio');
    }
    if (box.read('corDoMarker') == null) {
      box.write('corDoMarker', corDoMarker.toString());
      log('Cor Marker Vazio');
    }
    if (box.read('corSelected') == null) {
      box.write('corSelected', corSelected.toString());
      log('Cor Selected Vazio');
    }
    if (box.read('corHoje') == null) {
      box.write('corHoje', corSelected.toString());
      log('Cor Hoje Vazio');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarra(context, 'Menu'),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Pacientes(),
                  ),
                );
              },
              child: txtnu('Lista de Pacientes', 17, 4),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddPaciente(),
                  ),
                );
              },
              child: txtnu('Adicionar Paciente', 17, 4),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AgendaPacientes(),
                  ),
                );
              },
              child: txtnu('Agenda de Pacientes', 17, 4),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Setup(),
                  ),
                );
              },
              child: txtnu('Setup', 17, 4),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MainCollapsingToolbar(),
                  ),
                );
              },
              child: txtnu('Sliver', 17, 4),
            ),
          ],
        ),
      ),
    );
  }
}
