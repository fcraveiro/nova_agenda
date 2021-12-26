import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:nova_agenda/conectar.dart';

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

  @override
  void initState() {
    super.initState();
    userFuture = lerAgenda();
  }

  Future<Map<DateTime, List>> lerAgenda() async {
    List campos = await conecta.getAgenda();
    log(campos.toString());
    log(campos.length.toString());
/*
    Map<DateTime, List> mapFetch = {};

    List<AppEvent> event = await conecta.getAgenda();


    for (int i = 0; i < event.length; i++) {
      var createTime = DateTime(event[i].createTime.year,
          event[i].createTime.month, event[i].createTime.day);
      var original = mapFetch[createTime];
      if (original == null) {
        print("null");
        mapFetch[createTime] = [event[i].tanggalEvent];
      } else {
        print(event[i].tanggalEvent);
        mapFetch[createTime] = List.from(original)
          ..addAll([event[i].tanggalEvent]);
      }
    }
    return mapFetch;

    */
    throw 'eee';
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
        body: Container(
          color: Colors.amber,
          width: 20,
          height: 20,
        ));
  }
}




/*

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

*/

/*    
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(campos.getString("events") ?? "{}")));
*/

