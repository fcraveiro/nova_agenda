import 'dart:developer';
import 'package:flutter/material.dart';
import 'dart:convert';

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
  String status;
  String message;
  List<Datum> data;

  Event({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String kodeEvent;
  DateTime tanggalEvent;
  String judulEvent;
  String lokasiEvent;
  String isiEvent;
  String fotoEvent;
  String waktuEvent;
  String statusEvent;
  String createBy;
  DateTime createTime;
  String updateBy;
  String updateTime;

  Datum({
    required this.kodeEvent,
    required this.tanggalEvent,
    required this.judulEvent,
    required this.lokasiEvent,
    required this.isiEvent,
    required this.fotoEvent,
    required this.waktuEvent,
    required this.statusEvent,
    required this.createBy,
    required this.createTime,
    required this.updateBy,
    required this.updateTime,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        kodeEvent: json["kodeEvent"],
        tanggalEvent: DateTime.parse(json["tanggalEvent"]),
        judulEvent: json["judulEvent"],
        lokasiEvent: json["lokasiEvent"],
        isiEvent: json["isiEvent"],
        fotoEvent: json["fotoEvent"],
        waktuEvent: json["waktuEvent"],
        statusEvent: json["statusEvent"],
        createBy: json["createBy"],
        createTime: DateTime.parse(json["createTime"]),
        updateBy: json["updateBy"],
        updateTime: json["updateTime"],
      );

  Map<String, dynamic> toJson() => {
        "kodeEvent": kodeEvent,
        "tanggalEvent":
            "${tanggalEvent.year.toString().padLeft(4, '0')}-${tanggalEvent.month.toString().padLeft(2, '0')}-${tanggalEvent.day.toString().padLeft(2, '0')}",
        "judulEvent": judulEvent,
        "lokasiEvent": lokasiEvent,
        "isiEvent": isiEvent,
        "fotoEvent": fotoEvent,
        "waktuEvent": waktuEvent,
        "statusEvent": statusEvent,
        "createBy": createBy,
        "createTime": createTime.toIso8601String(),
        "updateBy": updateBy,
        "updateTime": updateTime,
      };
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Datum>> getAllEvent() async {
    try {
      //final response = await http.get(_baseUrl);
      String responseString = '''
{
    "status": "ok",
    "message": "Event Is Found",
    "data": [
        {
            "kodeEvent": "1",
            "tanggalEvent": "2020-01-15",
            "judulEvent": "Evento 1a",
            "lokasiEvent": "Lombok",
            "isiEvent": "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
            "fotoEvent": "event_5e4b8cd198530_202002181405.jpg",
            "waktuEvent": "09:00 s.d Selesai",
            "statusEvent": "t",
            "createBy": "0",
            "createTime": "2020-01-29 16:37:26",
            "updateBy": "",
            "updateTime": "2020-02-18 14:05:53"
        },
        {
            "kodeEvent": "2",
            "tanggalEvent": "2020-03-31",
            "judulEvent": "Evento 1b",
            "lokasiEvent": "Jakarta",
            "isiEvent": "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
            "fotoEvent": "event_5e4b8d3d74b44_202002181407.jpg",
            "waktuEvent": "09:00 s.d Selesai",
            "statusEvent": "t",
            "createBy": "",
            "createTime": "2020-02-18 14:07:41",
            "updateBy": "",
            "updateTime": "0000-00-00 00:00:00"
        },
        {
            "kodeEvent": "3",
            "tanggalEvent": "2020-01-31",
            "judulEvent": "Evento 2b",
            "lokasiEvent": "Bandung",
            "isiEvent": "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
            "fotoEvent": "event_5e4b8d72e2d37_202002181408.jpg",
            "waktuEvent": "09:00 s.d Selesai",
            "statusEvent": "t",
            "createBy": "",
            "createTime": "2020-02-18 14:08:34",
            "updateBy": "",
            "updateTime": "0000-00-00 00:00:00"
        }      
    ]
}
    ''';

      final Map<String, dynamic> responseJson = json.decode(responseString);
      if (responseJson["status"] == "ok") {
        List eventList = responseJson['data'];
        final result =
            eventList.map<Datum>((json) => Datum.fromJson(json)).toList();
        return result;
      } else {
        //throw CustomError(responseJson['message']);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
    throw 'iuu';
  }

  Future<Map<DateTime, List>> getTask1() async {
    Map<DateTime, List> mapFetch = {};
    List<Datum> event = await getAllEvent();
    for (int i = 0; i < event.length; i++) {
      var createTime = DateTime(event[i].createTime.year,
          event[i].createTime.month, event[i].createTime.day);
      var original = mapFetch[createTime];
      if (original == null) {
        mapFetch[createTime] = [event[i].judulEvent];
//        log('EVENTO = ${event[i].isiEvent.toString()}');
      } else {
        mapFetch[createTime] = List.from(original)
          ..addAll([event[i].judulEvent]);
      }
    }
    log('Final ${mapFetch.toString()}');
    return mapFetch;
  }

  @override
  void initState() {
    super.initState();

//    getAllEvent();
//    getTask();
    getTask1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('title'),
      ),
      body: Container(
        height: 10,
        width: 10,
        color: Colors.amber,
      ),
    );
  }
}

/*
class EventModel {
  String kodeEvent;
  DateTime tanggalEvent;
  String judulEvent;
  String lokasiEvent;
  String isiEvent;
  String fotoEvent;
  String waktuEvent;
  String statusEvent;
  String createBy;
  DateTime createTime;
  String updateBy;
  String updateTime;

  EventModel({
    required this.kodeEvent,
    required this.tanggalEvent,
    required this.judulEvent,
    required this.lokasiEvent,
    required this.isiEvent,
    required this.fotoEvent,
    required this.waktuEvent,
    required this.statusEvent,
    required this.createBy,
    required this.createTime,
    required this.updateBy,
    required this.updateTime,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        kodeEvent: json["kodeEvent"],
        tanggalEvent: DateTime.parse(json["tanggalEvent"]),
        judulEvent: json["judulEvent"],
        lokasiEvent: json["lokasiEvent"],
        isiEvent: json["isiEvent"],
        fotoEvent: json["fotoEvent"],
        waktuEvent: json["waktuEvent"],
        statusEvent: json["statusEvent"],
        createBy: json["createBy"],
        createTime: DateTime.parse(json["createTime"]),
        updateBy: json["updateBy"],
        updateTime: json["updateTime"],
      );
}
*/

/*

import 'dart:developer';
import 'package:flutter/material.dart';
import 'dart:convert';

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
  String status;
  String message;
  List<Datum> data;

  Event({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String kodeEvent;
  DateTime tanggalEvent;
  String judulEvent;
  String lokasiEvent;
  String isiEvent;
  String fotoEvent;
  String waktuEvent;
  String statusEvent;
  String createBy;
  DateTime createTime;
  String updateBy;
  String updateTime;

  Datum({
    required this.kodeEvent,
    required this.tanggalEvent,
    required this.judulEvent,
    required this.lokasiEvent,
    required this.isiEvent,
    required this.fotoEvent,
    required this.waktuEvent,
    required this.statusEvent,
    required this.createBy,
    required this.createTime,
    required this.updateBy,
    required this.updateTime,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        kodeEvent: json["kodeEvent"],
        tanggalEvent: DateTime.parse(json["tanggalEvent"]),
        judulEvent: json["judulEvent"],
        lokasiEvent: json["lokasiEvent"],
        isiEvent: json["isiEvent"],
        fotoEvent: json["fotoEvent"],
        waktuEvent: json["waktuEvent"],
        statusEvent: json["statusEvent"],
        createBy: json["createBy"],
        createTime: DateTime.parse(json["createTime"]),
        updateBy: json["updateBy"],
        updateTime: json["updateTime"],
      );

  Map<String, dynamic> toJson() => {
        "kodeEvent": kodeEvent,
        "tanggalEvent":
            "${tanggalEvent.year.toString().padLeft(4, '0')}-${tanggalEvent.month.toString().padLeft(2, '0')}-${tanggalEvent.day.toString().padLeft(2, '0')}",
        "judulEvent": judulEvent,
        "lokasiEvent": lokasiEvent,
        "isiEvent": isiEvent,
        "fotoEvent": fotoEvent,
        "waktuEvent": waktuEvent,
        "statusEvent": statusEvent,
        "createBy": createBy,
        "createTime": createTime.toIso8601String(),
        "updateBy": updateBy,
        "updateTime": updateTime,
      };
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<EventModel>> getAllEvent() async {
    try {
      //final response = await http.get(_baseUrl);
      String responseString = '''
{
    "status": "ok",
    "message": "Event Is Found",
    "data": [
        {
            "kodeEvent": "1",
            "tanggalEvent": "2020-01-15",
            "judulEvent": "Evento 1a",
            "lokasiEvent": "Lombok",
            "isiEvent": "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
            "fotoEvent": "event_5e4b8cd198530_202002181405.jpg",
            "waktuEvent": "09:00 s.d Selesai",
            "statusEvent": "t",
            "createBy": "0",
            "createTime": "2020-01-29 16:37:26",
            "updateBy": "",
            "updateTime": "2020-02-18 14:05:53"
        },
        {
            "kodeEvent": "2",
            "tanggalEvent": "2020-03-31",
            "judulEvent": "Evento 1b",
            "lokasiEvent": "Jakarta",
            "isiEvent": "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
            "fotoEvent": "event_5e4b8d3d74b44_202002181407.jpg",
            "waktuEvent": "09:00 s.d Selesai",
            "statusEvent": "t",
            "createBy": "",
            "createTime": "2020-02-18 14:07:41",
            "updateBy": "",
            "updateTime": "0000-00-00 00:00:00"
        },
        {
            "kodeEvent": "3",
            "tanggalEvent": "2020-01-31",
            "judulEvent": "Evento 2b",
            "lokasiEvent": "Bandung",
            "isiEvent": "Gempa Bumi dahsyat bertubi-tubi guncang lombok, kini Pulau seribu Masjid lemah tak berdaya, Lebih dari 500 Masjid dan Mushalla rata dengan tanah, kini ibadah saudara kita harus bertebaran dimana-mana , masih banyak warga yang tak bisa melaksanakan shalat dengan nyaman. Lokasi masjid dan mushalla sudah tak dapat dipake kembali , semua rusak parah dan bahkan sudh rata dengan tanah.<br /><br />Terpaksa mereka shalat di luar, tempat terbuka , bahkan di atas reruntuhan bangunan rumah sekalipun. Kini tak kurang dari 300 Masjid dan Mushalla yang dilaporkan rusak, dan lebih dari 70 masjid yang hancur rata dengan tanah karena gempa. semua masjid ini tersebar di 3 kabupaten (lombok utara, lombok barat dan lombok timur).",
            "fotoEvent": "event_5e4b8d72e2d37_202002181408.jpg",
            "waktuEvent": "09:00 s.d Selesai",
            "statusEvent": "t",
            "createBy": "",
            "createTime": "2020-02-18 14:08:34",
            "updateBy": "",
            "updateTime": "0000-00-00 00:00:00"
        }      
    ]
}
    ''';

      final Map<String, dynamic> responseJson = json.decode(responseString);
      if (responseJson["status"] == "ok") {
        List eventList = responseJson['data'];
        final result = eventList
            .map<EventModel>((json) => EventModel.fromJson(json))
            .toList();
        return result;
      } else {
        //throw CustomError(responseJson['message']);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
    throw 'iuu';
  }

  Future<Map<DateTime, List>> getTask1() async {
    Map<DateTime, List> mapFetch = {};
    List<EventModel> event = await getAllEvent();
    for (int i = 0; i < event.length; i++) {
      var createTime = DateTime(event[i].createTime.year,
          event[i].createTime.month, event[i].createTime.day);
      var original = mapFetch[createTime];
      if (original == null) {
        mapFetch[createTime] = [event[i].judulEvent];
//        log('EVENTO = ${event[i].isiEvent.toString()}');
      } else {
        mapFetch[createTime] = List.from(original)
          ..addAll([event[i].judulEvent]);
      }
    }
    log('Final ${mapFetch.toString()}');
    return mapFetch;
  }

  @override
  void initState() {
    super.initState();

//    getAllEvent();
//    getTask();
    getTask1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('title'),
      ),
      body: Container(
        height: 10,
        width: 10,
        color: Colors.amber,
      ),
    );
  }
}

class EventModel {
  String kodeEvent;
  DateTime tanggalEvent;
  String judulEvent;
  String lokasiEvent;
  String isiEvent;
  String fotoEvent;
  String waktuEvent;
  String statusEvent;
  String createBy;
  DateTime createTime;
  String updateBy;
  String updateTime;

  EventModel({
    required this.kodeEvent,
    required this.tanggalEvent,
    required this.judulEvent,
    required this.lokasiEvent,
    required this.isiEvent,
    required this.fotoEvent,
    required this.waktuEvent,
    required this.statusEvent,
    required this.createBy,
    required this.createTime,
    required this.updateBy,
    required this.updateTime,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        kodeEvent: json["kodeEvent"],
        tanggalEvent: DateTime.parse(json["tanggalEvent"]),
        judulEvent: json["judulEvent"],
        lokasiEvent: json["lokasiEvent"],
        isiEvent: json["isiEvent"],
        fotoEvent: json["fotoEvent"],
        waktuEvent: json["waktuEvent"],
        statusEvent: json["statusEvent"],
        createBy: json["createBy"],
        createTime: DateTime.parse(json["createTime"]),
        updateBy: json["updateBy"],
        updateTime: json["updateTime"],
      );
}


*/