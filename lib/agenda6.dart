import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:nova_agenda/conectar.dart';
import 'package:supabase/supabase.dart';
import 'package:table_calendar/table_calendar.dart';

import 'model.dart';

class CustomTableCalendar extends StatefulWidget {
  const CustomTableCalendar({Key? key}) : super(key: key);

  @override
  _CustomTableCalendarState createState() => _CustomTableCalendarState();
}

class _CustomTableCalendarState extends State<CustomTableCalendar> {
  final client = SupabaseClient(supabaseUrl, supabaseKey);

  final todaysDate = DateTime.now();
  var _focusedCalendarDate = DateTime.now();
  final _initialCalendarDate = DateTime(2000);
  final _lastCalendarDate = DateTime(2050);
  DateTime? selectedCalendarDate;
  final titleController = TextEditingController();
  final descpController = TextEditingController();
  CalendarFormat format = CalendarFormat.month;

  late Map<DateTime, List<MyEvents>> mySelectedEvents;

  @override
  void initState() {
    selectedCalendarDate = _focusedCalendarDate;
    mySelectedEvents = {};
    lerAgora();
    super.initState();
  }

  int numero = 0;

  Future<List> lerAgora() async {
    final response = await client.from('teste').select().execute();
    if (response.error == null) {
      final dataList = response.data as List;
      log(dataList.length.toString());
      for (var i = 0; i < dataList.length; i++) {
        var evento = (Eventos.fromJson(dataList[i]));
        numero = numero + 1;
        DateTime campo = DateTime.utc(
            evento.agendaData.year,
            evento.agendaData.month,
            evento.agendaData.day,
            evento.agendaData.hour,
            evento.agendaData.minute,
            evento.agendaData.second);
        if (mySelectedEvents[campo] != null) {
          mySelectedEvents[campo]?.add(MyEvents(
            agendaTitulo: evento.agendaTitulo,
            agendaDesc: evento.agendaDesc,
            agendaCancelado: false,
            agendaExcluido: false,
            agendaRemarcado: false,
            agendaTratado: false,
            agendaData: campo,
            agendaNome: evento.agendaNome,
            agendaHora: evento.agendaHora,
            agendaPac: evento.agendaPac,
            agendaUuId: evento.agendaUuId,
          ));
          _listOfDayEvents(campo);
        } else {
          mySelectedEvents[campo] = [
            MyEvents(
              agendaTitulo: evento.agendaTitulo,
              agendaDesc: evento.agendaDesc,
              agendaCancelado: false,
              agendaExcluido: false,
              agendaRemarcado: false,
              agendaTratado: false,
              agendaData: campo,
              agendaNome: evento.agendaNome,
              agendaHora: evento.agendaHora,
              agendaPac: evento.agendaPac,
              agendaUuId: evento.agendaUuId,
            )
          ];
          _listOfDayEvents(campo);
        }
        setState(() {
          _listOfDayEvents(campo);
        });
//        log('Data $numero ${campo.toString()}');
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

  List<MyEvents> _listOfDayEvents(DateTime dateTime) {
    return mySelectedEvents[dateTime] ?? [];
  }

  _showAddEventDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('New Event'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildTextField(
                      controller: titleController, hint: 'Enter Title'),
                  const SizedBox(
                    height: 20.0,
                  ),
                  buildTextField(
                      controller: descpController, hint: 'Enter Description'),
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
                          mySelectedEvents[selectedCalendarDate]?.add(MyEvents(
                            agendaTitulo: titleController.text,
                            agendaDesc: descpController.text,
                            agendaCancelado: false,
                            agendaExcluido: false,
                            agendaRemarcado: false,
                            agendaTratado: false,
                            agendaData: DateTime.now(),
                            agendaNome: 'lll',
                            agendaHora: 'now()',
                            agendaPac: 1,
                            agendaUuId: 'sjahsadkjhajshjksad',
                          ));
                          _listOfDayEvents(selectedCalendarDate!);
                        } else {
                          mySelectedEvents[selectedCalendarDate!] = [
                            MyEvents(
                              agendaTitulo: titleController.text,
                              agendaDesc: descpController.text,
                              agendaCancelado: false,
                              agendaExcluido: false,
                              agendaRemarcado: false,
                              agendaTratado: false,
                              agendaData: DateTime.now(),
                              agendaNome: 'lll',
                              agendaHora: 'now()',
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
    return SafeArea(
      child: Scaffold(
        //      appBar: AppBar(
        //        title: const Text('Custom Calendar'),
        //      ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showAddEventDialog(),
          label: const Text('Add Event'),
          splashColor: Colors.black,
//          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                // as per the documentation
                if (!isSameDay(selectedCalendarDate, selectedDay)) {
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
                formatButtonTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                formatButtonShowsNext: false,
              ),
              calendarStyle: const CalendarStyle(
                canMarkersOverflow: true,
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
                    color: Colors.grey.withOpacity(0.5),
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
            ..._listOfDayEvents(selectedCalendarDate!).map(
              (myEvents) => Expanded(
                child: ListTile(
                  leading: const Icon(
                    Icons.done,
                    color: Colors.indigo,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8.0,
                    ),
                    child: Text('Event Title:   ${myEvents.agendaTitulo}'),
                  ),
                  subtitle: Text('Description:   ${myEvents.agendaDesc}'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}