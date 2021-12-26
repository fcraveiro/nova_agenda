import 'dart:collection';
import 'dart:developer';

/*
import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:firebasestarter/core/presentation/providers/providers.dart';
import 'package:firebasestarter/features/events/data/models/app_event.dart';
import 'package:firebasestarter/features/events/data/services/event_firestore_service.dart';
import 'package:firebasestarter/core/presentation/res/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
*/

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nova_agenda/conectar.dart';
import 'package:table_calendar/table_calendar.dart';
import '/colors.dart';
import '/sizes.dart';
import 'model.dart';

class Agenda extends StatefulWidget {
  const Agenda({Key? key}) : super(key: key);

  @override
  _AgendaState createState() => _AgendaState();
}

var teste = TimeOfDay.now().toString();
late Future userFuture;
DateTime campo = DateTime.now();
var selectedEvents = {};
final kNow = DateTime.now();
final kFirstDay = DateTime(kNow.year, kNow.month - 3, kNow.day);
final kLastDay = DateTime(kNow.year, kNow.month + 3, kNow.day);
List evento = [];

class _AgendaState extends State<Agenda> {
  Conecta conecta = Conecta();
  late LinkedHashMap<DateTime, List<AppEvent>> _groupedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    userFuture = lerAgenda();
  }

  lerAgenda() async {
    List campos = await conecta.getAgenda();
    log(campos.toString());

/*

    final eventDBS = DatabaseService<AppEvent>(
  AppDBConstants.eventsCollection,
  fromDS:
  
   (id, data) =>    
  AppEvent.fromDS(id, data),
  toMap: (event) => event.toMap(),
);





prefsData() async {
  prefs = await SharedPreferences.getInstance();
  setState(() {
    _events = Map<DateTime, List<dynamic>>.from(
        decodeMap(json.decode(prefs.getString("events") ?? "{}")));
  });
}

Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
  Map<String, dynamic> newMap = {};
  map.forEach((key, value) {
    newMap[key.toString()] = map[key];
  });
  return newMap;
}
Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
  Map<DateTime, dynamic> newMap = {};
  map.forEach((key, value) {
    newMap[DateTime.parse(key)] = map[key];
  });
  return newMap;
}














..._selectedEvents.map((event) => Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    height: MediaQuery.of(context).size.height/20,
    width: MediaQuery.of(context).size.width/2,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        border: Border.all(color: Colors.grey)
    ),
    child: Center(
        child: Text(event,
          style: TextStyle(color: Colors.blue,
              fontWeight: FontWeight.bold,fontSize: 16),)
    ),
  ),
)),












    

Map<DateTime, List<dynamic>> _events;
List<dynamic> _selectedEvents;

@override
void initState() {
  super.initState();
  _events = {};
  _selectedEvents = [];
}
In TableCalendar, let us assign events as underscore events. Whenever the day is selected, set state, so interval calendar on the day selected property.
onDaySelected: (date, events,holidays) {
  setState(() {
    _selectedEvents = events;
  });
},



    for (var i = 0; i < campos.length; i++) {
      var evento = (AppEvent.fromJson(campos[i]));

  AppEvent.fromDS(evento.agendaPac.toString(), evento.agendaData),
  toMap: (event) => event.toMap();

*/
//          future: lerAgenda(),
//             (id, data) =>

//    for (var i = 0; i < campos.length; i++) {
//      var evento = (Eventos.fromJson(campos[i]));
//      }
//    }
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  void didChangeDependencies() {
/*
    context.read(pnProvider).init();
*/
    super.didChangeDependencies();
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  _groupEvents(List<AppEvent> events) {
    _groupedEvents = LinkedHashMap(equals: isSameDay, hashCode: getHashCode);
    for (var event in events) {
      DateTime date = DateTime.utc(event.agendaData.year,
          event.agendaData.month, event.agendaData.day, 12);
      if (_groupedEvents[date] == null) _groupedEvents[date] = [];
      _groupedEvents[date]?.add(event);
    }
  }

  List<dynamic> _getEventsForDay(DateTime date) {
    return _groupedEvents[date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda Oficial'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              log('icon');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: userFuture,

/*
            QueryArgsV2(
              "user_id",
              isEqualTo: context.read(userRepoProvider).user.id,
            ),
          ]),

final eventDBS = DatabaseService<AppEvent>(
  AppDBConstants.eventsCollection,
  fromDS:
  
   (id, data) => 
   
   
  AppEvent.fromDS(id, data),
  toMap: (event) => event.toMap(),
);



*/

          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              final events = snapshot.data;
              _groupEvents(events);
              DateTime selectedDate = _selectedDay;
              final _selectedEvents = _groupedEvents[selectedDate] ?? [];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.all(8.0),
                    child: TableCalendar(
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(day, _selectedDay),
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      eventLoader: _getEventsForDay,
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },
                      weekendDays: const [6],
                      headerStyle: HeaderStyle(
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                        ),
                        headerMargin: const EdgeInsets.only(bottom: 8.0),
                        titleTextStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        formatButtonDecoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius:
                              BorderRadius.circular(AppSizes.borderRadius),
                        ),
                        formatButtonTextStyle:
                            const TextStyle(color: Colors.white),
                        leftChevronIcon: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                        ),
                        rightChevronIcon: const Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                      ),
                      calendarStyle: const CalendarStyle(),
                      calendarBuilders: const CalendarBuilders(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 8.0),
                    child: Text(
                      DateFormat('EEEE, dd MMMM, yyyy').format(selectedDate),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _selectedEvents.length,
                    itemBuilder: (BuildContext context, int index) {
                      AppEvent event = _selectedEvents[index];
                      return ListTile(
                        title: Text(event.agendaTitulo),
                        subtitle: Text(DateFormat("EEEE, dd MMMM, yyyy")
                            .format(event.agendaData)),
                        onTap: () => {},
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => {},
                        ),
                      );
                    },
                  ),
                ],
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          log('Float');
        },
      ),
    );
  }
}
