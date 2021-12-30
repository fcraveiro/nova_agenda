class ClassPaciente {
  String pacUuId;
  int pacId;
  String pacNome;
  String pacEnde;
  String pacCity;
  String pacEst;
  int pacCep;
  int pacFone;
  int pacCel;
  bool pacZap1;
  bool pacZap2;
  bool pacFavorito;
  bool pacTratando;
  bool pacAviso1;
  bool pacAviso2;
  bool pacAviso3;
  bool pacAviso4;
  bool pacAviso5;
  bool pacAviso6;

  ClassPaciente({
    required this.pacUuId,
    required this.pacId,
    required this.pacNome,
    required this.pacEnde,
    required this.pacCity,
    required this.pacEst,
    required this.pacCep,
    required this.pacFone,
    required this.pacCel,
    required this.pacZap1,
    required this.pacZap2,
    required this.pacFavorito,
    required this.pacTratando,
    required this.pacAviso1,
    required this.pacAviso2,
    required this.pacAviso3,
    required this.pacAviso4,
    required this.pacAviso5,
    required this.pacAviso6,
  });

  factory ClassPaciente.fromJson(Map<String, dynamic> map) {
    return ClassPaciente(
        pacUuId: map['pacUuId'.toString()],
        pacId: map['pacId'],
        pacNome: map['pacNome'.toString()],
        pacEnde: map['pacEnde'.toString()],
        pacCity: map['pacCity'.toString()],
        pacEst: map['pacEst'.toString()],
        pacCep: map['pacCep'],
        pacFone: map['pacFone'],
        pacCel: map['pacCel'],
        pacZap1: map['pacZap1'],
        pacZap2: map['pacZap2'],
        pacFavorito: map['pacFavorito'],
        pacTratando: map['pacTratando'],
        pacAviso1: map['pacAviso1'],
        pacAviso2: map['pacAviso2'],
        pacAviso3: map['pacAviso3'],
        pacAviso4: map['pacAviso4'],
        pacAviso5: map['pacAviso5'],
        pacAviso6: map['pacAviso6']);
  }

  Map<String, dynamic> toJson() => {
        'pacId': pacId,
        'pacNome': pacNome,
        'pacEnde': pacEnde,
        'pacCity': pacCity,
        'pacEst': pacEst,
        'pacCep': pacCep,
        'pacFone': pacFone,
        'pacCel': pacCel,
        'pacZap1': pacZap1,
        'pacZap2': pacZap2,
        'pacFavorito': pacFavorito,
        'pacTratando': pacTratando,
        'pacAviso1': pacAviso1,
        'pacAviso2': pacAviso2,
        'pacAviso3': pacAviso3,
        'pacAviso4': pacAviso4,
        'pacAviso5': pacAviso5,
        'pacAviso6': pacAviso6,
      };
}

class Historico {
//  DateTime createdAt;
  int hisIdPaciente;
  String hisPathThumb;
  String hisPathServer;
  bool hisFoto;

  Historico({
//    required this.createdAt,
    required this.hisIdPaciente,
    required this.hisPathThumb,
    required this.hisPathServer,
    required this.hisFoto,
  });

  factory Historico.fromJson(Map<String, dynamic> map) {
    return Historico(
//      createdAt: map['createdAt'.toString()],
      hisIdPaciente: map['hisIdPaciente'.toString()],
      hisPathThumb: map['hisPathThumb'.toString()],
      hisPathServer: map['hisPathServer'.toString()],
      hisFoto: map['hisFoto'],
    );
  }
}

/*

  static DateTime agendaDay(t) => t as DateTime;
            "${agendaDay.year.toString().padLeft(4, '0')}-${agendaDay.month.toString().padLeft(2, '0')}-${agendaDay.day.toString().padLeft(2, '0')}",


        agendaDay: DateTime.parse(json["agendaDay"]),


    factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
      Map<String, dynamic> toJson() => _$PersonToJson(this);


      static DateTime _fromJson(int int) => DateTime.fromMillisecondsSinceEpoch(int);
      static int _toJson(DateTime time) => time.millisecondsSinceEpoch;
 static DateTime _rawDateTime(t) => t as DateTime;
*/

class Agenda {
  final String agendaUuId;
  final int agendaPac;
  final String agendaNome;
  final String agendaTitulo;
  final String agendaDesc;
  final DateTime agendaData;
  final int agendaHora;
  final int agendaMinuto;
  final bool agendaCancelado;
  final bool agendaTratado;
  final bool agendaExcluido;
  final bool agendaRemarcado;

  Agenda({
    required this.agendaUuId,
    required this.agendaPac,
    required this.agendaNome,
    required this.agendaTitulo,
    required this.agendaDesc,
    required this.agendaData,
    required this.agendaHora,
    required this.agendaMinuto,
    required this.agendaCancelado,
    required this.agendaExcluido,
    required this.agendaTratado,
    required this.agendaRemarcado,
  });

  factory Agenda.fromJson(Map<String, dynamic> json) => Agenda(
        agendaUuId: json['agendaUuId'].toString(),
        agendaPac: json['agendaPac'],
        agendaNome: json['agendaNome'],
        agendaTitulo: json['agendaTitulo'].toString(),
        agendaDesc: json['agendaDesc'].toString(),
        agendaData: DateTime.parse(json["agendaData"]),
        agendaHora: json["agendaHora"],
        agendaMinuto: json["agendaMinuto"],
        agendaCancelado: json["agendaCancelado"],
        agendaTratado: json["agendaTratado"],
        agendaRemarcado: json["agendaRemarcado"],
        agendaExcluido: json["agendaExcluido"],
      );

  Map<String, dynamic> toJson() => {
        "agendaUuId": agendaUuId,
        "agendaPac": agendaPac,
        "agendaNome": agendaNome,
        "agendaTitulo": agendaTitulo,
        "agendaDesc": agendaDesc,
        "agendaData": agendaData,
        "agendaHora": agendaHora,
        "agendaMinuto": agendaMinuto,
        "agendaCancelado": agendaCancelado,
        "agendaTratado": agendaTratado,
        "agendaExcluido": agendaExcluido,
        "agendaRemarcado": agendaRemarcado,
      };

  factory Agenda.fromMap(Map data) {
    return Agenda(
      agendaUuId: data['agendaUuId'],
      agendaPac: data['agendaPac'],
      agendaNome: data['agendaNome'],
      agendaTitulo: data['agendaTitulo'],
      agendaDesc: data['agendaDesc'],
      agendaData: data['agendaData'],
      agendaHora: data['agendaHora'],
      agendaMinuto: data['agendaMinuto'],
      agendaCancelado: data['agendaCancelado'],
      agendaRemarcado: data['agendaRemarcado'],
      agendaExcluido: data['agendaExcluido'],
      agendaTratado: data['agendaTratado'],
    );
  }
}
