import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:nova_agenda/conectar.dart';
import 'package:nova_agenda/model.dart';
import 'package:supabase/supabase.dart';

String eventToJson(Event data) => json.encode(data.toJson());

const supabaseUrl = 'https://xrhyhsbetlnzksauwrvi.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzODA3NTI4MywiZXhwIjoxOTUzNjUxMjgzfQ.gsz31qxeQ_h6R_93rthZwynvz1i8jNrXLz30JaFprqA';

class Teste5 extends StatefulWidget {
  const Teste5({Key? key}) : super(key: key);

  @override
  _Teste5State createState() => _Teste5State();
}

class _Teste5State extends State<Teste5> {
  Conecta conecta = Conecta();

  late List _selectedEvents;
  late Map<DateTime, List> _events;

  Future<List<Agenda>> getAllEvent() async {
    final client = SupabaseClient(supabaseUrl, supabaseKey);
    log('Leu Agenda 4');
    final response = await client.from('teste').select().execute();
    if (response.error == null) {
      final dataList = response.data as List;
      List eventList = dataList;
      final result =
          eventList.map<Agenda>((json) => Agenda.fromJson(json)).toList();
      return result;
    } else {
      throw 'ss';
    }
  }

  Future<Map<DateTime, List>> getTask1() async {
    Map<DateTime, List> mapFetch = {};
    List<Agenda> event = await getAllEvent();
    for (int i = 0; i < event.length; i++) {
      var createTime = DateTime(event[i].agendaData.year,
          event[i].agendaData.month, event[i].agendaData.day);
      var original = mapFetch[createTime];
      if (original == null) {
        mapFetch[createTime] = [event[i].agendaData];
      } else {
        log(event[i].agendaData.toString());
        mapFetch[createTime] = List.from(original)
          ..addAll([event[i].agendaData]);
        log('Lista > ${mapFetch.toString()} \n');
      }
    }
    log(mapFetch.toString());
    return mapFetch;
  }

  // ignore: unused_element
  void _onDaySelected(DateTime day, List events) {
    log('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  @override
  void initState() {
//    final _selectedDay = DateTime.now();
    _selectedEvents = [];
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getTask1().then((val) => setState(() {
            _events = val;
          }));
      //print( ' ${_events.toString()} ');
    });
    super.initState();
  }

/////////////////////////////////////////////////////////////////////////////////////////

}

/*
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
            "judulEvent": "Bangun Kembali 200 Masjid dan Mushalla Anti Gempa",
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
            "judulEvent": "Bangun Kembali 100 Masjid dan Mushalla Anti Gempa",
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
            "judulEvent": "Bangun Kembali 200 Masjid dan Mushalla Anti Gempa",
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

*/




/*
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

*/



/*


  Future<Map<DateTime, List>> getTask() async {
    Map<DateTime, List> mapFetch = {};

    await Future.delayed(const Duration(seconds: 3), () {});

    /*String link = baseURL + fetchTodoByDate;
    var res = await http.post(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      // need help in creating fetch logic here
    }*/

    String responseString = '''
{
    "status": "ok",
    "message": "Event Is Found",
    "data": [
        {
            "kodeEvent": "1",
            "tanggalEvent": "2020-01-15",
            "judulEvent": "Bangun Kembali 200 Masjid dan Mushalla Anti Gempa",
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
            "judulEvent": "Bangun Kembali 100 Masjid dan Mushalla Anti Gempa",
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
            "judulEvent": "Bangun Kembali 200 Masjid dan Mushalla Anti Gempa",
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

    Event event = eventFromJson(responseString);

    for (int i = 0; i < event.data.length; i++) {
      var createTime = DateTime(event.data[i].createTime.year,
          event.data[i].createTime.month, event.data[i].createTime.day);
      var original = mapFetch[createTime];
      if (original == null) {
        log("null");
        mapFetch[createTime] = [event.data[i].tanggalEvent];
      } else {
        log(event.data[i].tanggalEvent.toString());
        mapFetch[createTime] = List.from(original)
          ..addAll([event.data[i].tanggalEvent]);
      }
    }

    return mapFetch;
  }
  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString()),
                  onTap: () => log('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('jj'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),

    );
  }
  

  */