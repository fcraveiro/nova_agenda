import 'package:flutter/material.dart';
import 'package:nova_agenda/paginas/addpacientes.dart';
import 'package:nova_agenda/paginas/agendapacientes.dart';
import 'package:nova_agenda/paginas/pacientes.dart';
import 'package:nova_agenda/paginas/setup.dart';
import '/services/widgets.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
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
          ],
        ),
      ),
    );
  }
}
