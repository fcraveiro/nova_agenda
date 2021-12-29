import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:nova_agenda/conectar.dart';
import 'package:supabase/supabase.dart';
import 'package:table_calendar/table_calendar.dart';
import 'model.dart';

class AgendaPacientes extends StatefulWidget {
  const AgendaPacientes({Key? key}) : super(key: key);

  @override
  _AgendaPacientesState createState() => _AgendaPacientesState();
}

class _AgendaPacientesState extends State<AgendaPacientes> {
  final client = SupabaseClient(supabaseUrl, supabaseKey);

  final todaysDate = DateTime.now();
  var _focusedCalendarDate = DateTime.now();
  final _initialCalendarDate = DateTime(2000);
  final _lastCalendarDate = DateTime(2050);
  DateTime? selectedCalendarDate;
  final titleController = TextEditingController();
  final descpController = TextEditingController();
  CalendarFormat format = CalendarFormat.month;

  late Map<DateTime, List<Agenda>> mySelectedEvents;

  @override
  void initState() {
    selectedCalendarDate = _focusedCalendarDate;
    mySelectedEvents = {};
    lerAgora();
    var aux = DateFormat("yyyy-MM-dd").format(todaysDate) + ' 00:00:00.000Z';
    var aux2 = aux.toString();
    DateTime teste = DateTime.parse(aux2);
    selectedCalendarDate = teste;
    setState(() {
      tata(selectedCalendarDate);
    });
    super.initState();
  }

  Future<List> lerAgora() async {
    final response = await client
        .from('teste')
        .select()
        .filter('agendaExcluido', 'eq', false)
        .order('agendaHora', ascending: true)
        .execute();
    if (response.error == null) {
      final dataList = response.data as List;
      log(dataList.length.toString());
      for (var i = 0; i < dataList.length; i++) {
        var evento = (Agenda.fromJson(dataList[i]));
        DateTime campo = DateTime.utc(
            evento.agendaData.year,
            evento.agendaData.month,
            evento.agendaData.day,
            evento.agendaData.hour,
            evento.agendaData.minute,
            evento.agendaData.second);
        if (mySelectedEvents[campo] != null) {
          mySelectedEvents[campo]?.add(Agenda(
            agendaTitulo: evento.agendaTitulo,
            agendaDesc: evento.agendaDesc,
            agendaCancelado: false,
            agendaExcluido: false,
            agendaRemarcado: false,
            agendaTratado: false,
            agendaData: campo,
            agendaNome: evento.agendaNome,
            agendaHora: evento.agendaHora,
            agendaMinuto: evento.agendaMinuto,
            agendaPac: evento.agendaPac,
            agendaUuId: evento.agendaUuId,
          ));
          _listOfDayEvents(campo);
        } else {
          mySelectedEvents[campo] = [
            Agenda(
              agendaTitulo: evento.agendaTitulo,
              agendaDesc: evento.agendaDesc,
              agendaCancelado: false,
              agendaExcluido: false,
              agendaRemarcado: false,
              agendaTratado: false,
              agendaData: campo,
              agendaNome: evento.agendaNome,
              agendaHora: evento.agendaHora,
              agendaMinuto: evento.agendaMinuto,
              agendaPac: evento.agendaPac,
              agendaUuId: evento.agendaUuId,
            )
          ];
          _listOfDayEvents(campo);
        }
        setState(() {
          _listOfDayEvents(campo);
        });
      }
      return (dataList);
    }
    log('Error fetching notes: ${response.error!.message}');
    return [];
  }

  @override
  void dispose() {
    titleController.dispose();
    descpController.dispose();
    super.dispose();
  }

  List<Agenda> _listOfDayEvents(DateTime dateTime) {
    return mySelectedEvents[dateTime] ?? [];
  }

  _showAddEventDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Novo Evento'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildTextField(controller: titleController, hint: 'Titulo'),
                  const SizedBox(
                    height: 20.0,
                  ),
                  buildTextField(
                      controller: descpController, hint: 'Descrição'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (titleController.text.isEmpty &&
                        descpController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter title & description'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      //Navigator.pop(context);
                      return;
                    } else {
                      setState(() {
                        if (mySelectedEvents[selectedCalendarDate] != null) {
                          mySelectedEvents[selectedCalendarDate]?.add(Agenda(
                            agendaTitulo: titleController.text,
                            agendaDesc: descpController.text,
                            agendaCancelado: false,
                            agendaExcluido: false,
                            agendaRemarcado: false,
                            agendaTratado: false,
                            agendaData: DateTime.now(),
                            agendaNome: 'lll',
                            agendaHora: 14,
                            agendaMinuto: 15,
                            agendaPac: 1,
                            agendaUuId: 'sjahsadkjhajshjksad',
                          ));
                          _listOfDayEvents(selectedCalendarDate!);
                        } else {
                          mySelectedEvents[selectedCalendarDate!] = [
                            Agenda(
                              agendaTitulo: titleController.text,
                              agendaDesc: descpController.text,
                              agendaCancelado: false,
                              agendaExcluido: false,
                              agendaRemarcado: false,
                              agendaTratado: false,
                              agendaData: DateTime.now(),
                              agendaNome: 'lll',
                              agendaHora: 19,
                              agendaMinuto: 55,
                              agendaPac: 1,
                              agendaUuId: 'sjahsadkjhajshjksad',
                            )
                          ];
                          _listOfDayEvents(selectedCalendarDate!);
                        }
                      });

                      titleController.clear();
                      descpController.clear();

                      Navigator.pop(context);
                      return;
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ));
  }

  Widget buildTextField(
      {String? hint, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: hint ?? '',
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.amber, width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Calendar'),
        centerTitle: true,
        leading:
            InkWell(onTap: () => {refaz2()}, child: const Icon(Icons.edit)),
        actions: [
          InkWell(
            onTap: () => _showAddEventDialog(),
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar(
              locale: 'pt_BR',
              focusedDay: _focusedCalendarDate,
              firstDay: _initialCalendarDate,
              lastDay: _lastCalendarDate,
              weekendDays: const [DateTime.sunday, 6],
              startingDayOfWeek: StartingDayOfWeek.monday,
              eventLoader: _listOfDayEvents,
              availableCalendarFormats: const {
                CalendarFormat.month: 'Semana',
                CalendarFormat.twoWeeks: 'Mês',
                CalendarFormat.week: '2 Semanas',
              },
              calendarFormat: format,
              onFormatChanged: (CalendarFormat _format) {
                setState(() {
                  format = _format;
                });
              },
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekendStyle: TextStyle(color: Colors.grey),
              ),
              selectedDayPredicate: (currentSelectedDate) {
                return (isSameDay(selectedCalendarDate!, currentSelectedDate));
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(selectedCalendarDate, selectedDay)) {
                  setState(() {
                    selectedCalendarDate = selectedDay;
                    _focusedCalendarDate = focusedDay;
                  });
                } else {
                  setState(() {
                    selectedCalendarDate = selectedDay;
                    _focusedCalendarDate = focusedDay;
                  });
                }
              },
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                decoration: const BoxDecoration(
                    //  color: Colors.amber,
                    ),
                formatButtonTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                formatButtonShowsNext: false,
              ),
              calendarStyle: const CalendarStyle(
                canMarkersOverflow: true,
                markerDecoration: BoxDecoration(
                    color: Color(0xFF757575), shape: BoxShape.circle),
                todayDecoration: BoxDecoration(
                  color: Colors.amber,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.pink,
                ),
                todayTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.black),
              ),
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(6.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: const TextStyle(color: Colors.white),
                    )),
                todayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(6.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(.4),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: const TextStyle(color: Colors.black),
                    )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    spreadRadius: 3,
                    blurRadius: 9,
                    offset: const Offset(0, 6), // changes position of shadow
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 2,
              height: 1,
              color: Color(0xFFBDBDBD),
            ),
            Expanded(
              child: tata(selectedCalendarDate),
            )
          ],
        ),
      ),
    );
  }

  tata(selectedDay) {
//    log('entrou');
//    log('Data certa ${selectedDay.toString()}');
    List<Agenda> jojo = _listOfDayEvents(selectedDay);
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10, right: 0, left: 0, bottom: 10),
      itemCount: jojo.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 65,
          color: Colors.amber,
          margin: const EdgeInsets.only(
            top: 6,
            left: 10,
            right: 10,
          ),
          child: Slidable(
            groupTag: '1',
            key: const ValueKey(0),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
/*
                                  remarcarAgenda(
                                      context, value[index].agendaUuId);
                                  setState(() {});
*/
                  },
                  backgroundColor: const Color(0xFF7BC043),
                  foregroundColor: Colors.white,
                  icon: Icons.calendar_today_rounded,
                  label: 'Remarcar',
                ),
                SlidableAction(
                  onPressed: (context) async {
                    await apagarAgenda(jojo[index].agendaUuId);
                    refaz(selectedCalendarDate);
                  },
                  backgroundColor: const Color(0xFF0392CF),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Cancelar',
                ),
              ],
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 65,
              color: const Color(0xFFD6D6D6),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 15,
                        height: 65,
                        color: corDaHora(jojo[index]
                            .agendaHora), // jojo[index].agendaHora == ,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 35,
                        height: 65,
                        child: ListTile(
                          dense: true,
                          onTap: () => {log('clicou')},
                          title: Text(
                            jojo[index].agendaNome,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            jojo[index].agendaTitulo,
                          ),
                          trailing: Text(
                            jojo[index].agendaHora.toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  refaz(selectedCalendarDate) {
    setState(() {
      mySelectedEvents = {};
      lerAgora();
      var aux = DateFormat("yyyy-MM-dd").format(selectedCalendarDate) +
          ' 00:00:00.000Z';
      var aux2 = aux.toString();
      DateTime teste = DateTime.parse(aux2);
      selectedCalendarDate = teste;
      tata(selectedCalendarDate);
    });
  }

  refaz2() async {
    Conecta conectar = Conecta();
    await conectar.voltaAgenda();
//    selectedEvents.clear();
    mySelectedEvents = {};
    await lerAgora();

    var aux = DateFormat("yyyy-MM-dd").format(todaysDate) + ' 00:00:00.000Z';
    var aux2 = aux.toString();
    DateTime teste = DateTime.parse(aux2);
    selectedCalendarDate = teste;
    tata(selectedCalendarDate);
//    refaz();
  }

/////////////////////////////    CANCELAR     /////////////////////////////////

  apagarAgenda(uuid) async {
    await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Motivo do Cancelamento'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('O Paciente avisou o Cancelamento'),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      var avisou = false;
                      await cancelarAgenda(context, uuid, avisou);
                      Navigator.pop(context);
                      return;
                    },
//                    style: ElevatedButton.styleFrom(
//                      primary: Colors.green.shade600, // background
//                      onPrimary: Colors.white, // foreground
//                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/imagens/nok.png',
                          width: 25,
                          height: 25,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
//                        const Text('Não'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      var avisou = true;
                      await cancelarAgenda(context, uuid, avisou);
                      Navigator.pop(context);
                      return;
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/imagens/ok.png',
                          width: 25,
                          height: 25,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
//                        const Text('Sim'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

cancelarAgenda(BuildContext context, uuid, avisou) async {
  Conecta conectar = Conecta();
  final response = await conectar.cancelAgenda(uuid, avisou);
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Cancelando Agendamento'),
      duration: Duration(seconds: 2),
    ),
  );
  log('Apagar : $uuid');
  log('Feito $response');
}

///////////////////////////////////////////////////////////////////////////////

remarcarAgenda(BuildContext context, uuid) {
  log('Remarcar : $uuid');
}

corDaHora(agendaHora) {
  var hour = agendaHora;
  if (hour == 12) {
//    log('Tarde');
    return Colors.green.shade700;
  } else if (hour == 18) {
//    log('Noite');
    return Colors.grey.shade700;
  } else if (hour < 8) {
//    log('Madrugada');
    return Colors.black;
  } else if (hour < 12) {
//    log('Manhã');
    return Colors.yellow.shade700;
  } else if (hour > 18) {
//    log('Noite');
    return Colors.grey.shade700;
  } else {
//    log('Tarde');
    return Colors.green.shade700;
  }
}
