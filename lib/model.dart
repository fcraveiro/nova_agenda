import 'dart:convert';

class AppEvent {
  final String agendaUuId;
  final int agendaPac;
  final String agendaNome;
  final String agendaTitulo;
  final String agendaDesc;
  final DateTime agendaData;
  final String agendaHora;
  final bool agendaCancelado;
  final bool agendaTratado;
  final bool agendaExcluido;
  final bool agendaRemarcado;
  AppEvent({
    required this.agendaUuId,
    required this.agendaPac,
    required this.agendaNome,
    required this.agendaTitulo,
    required this.agendaDesc,
    required this.agendaData,
    required this.agendaHora,
    required this.agendaCancelado,
    required this.agendaTratado,
    required this.agendaExcluido,
    required this.agendaRemarcado,
  });

  AppEvent copyWith({
    String? agendaUuId,
    int? agendaPac,
    String? agendaNome,
    String? agendaTitulo,
    String? agendaDesc,
    DateTime? agendaData,
    String? agendaHora,
    bool? agendaCancelado,
    bool? agendaTratado,
    bool? agendaExcluido,
    bool? agendaRemarcado,
  }) {
    return AppEvent(
      agendaUuId: agendaUuId ?? this.agendaUuId,
      agendaPac: agendaPac ?? this.agendaPac,
      agendaNome: agendaNome ?? this.agendaNome,
      agendaTitulo: agendaTitulo ?? this.agendaTitulo,
      agendaDesc: agendaDesc ?? this.agendaDesc,
      agendaData: agendaData ?? this.agendaData,
      agendaHora: agendaHora ?? this.agendaHora,
      agendaCancelado: agendaCancelado ?? this.agendaCancelado,
      agendaTratado: agendaTratado ?? this.agendaTratado,
      agendaExcluido: agendaExcluido ?? this.agendaExcluido,
      agendaRemarcado: agendaRemarcado ?? this.agendaRemarcado,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'agendaUuId': agendaUuId,
      'agendaPac': agendaPac,
      'agendaNome': agendaNome,
      'agendaTitulo': agendaTitulo,
      'agendaDesc': agendaDesc,
      'agendaData': agendaData.millisecondsSinceEpoch,
      'agendaHora': agendaHora,
      'agendaCancelado': agendaCancelado,
      'agendaTratado': agendaTratado,
      'agendaExcluido': agendaExcluido,
      'agendaRemarcado': agendaRemarcado,
    };
  }

  factory AppEvent.fromDS(String id, Map<String, dynamic> data) {
    // ignore: unnecessary_null_comparison
    return AppEvent(
      agendaUuId: data['agendaUuId'],
      agendaPac: data['agendaPac'],
      agendaNome: data['agendaNome'],
      agendaTitulo: data['agendaTitulo'],
      agendaDesc: data['agendaDesc'] ?? '',
      agendaData: DateTime.fromMillisecondsSinceEpoch(data['agendaData']),
      agendaHora: data['agendaHora'],
      agendaCancelado: data['agendaCancelado'],
      agendaTratado: data['agendaTratado'],
      agendaExcluido: data['agendaExcluido'],
      agendaRemarcado: data['agendaRemarcado'],
    );
  }

  factory AppEvent.fromMap(Map<String, dynamic> map) {
    return AppEvent(
      agendaUuId: map['agendaUuId'] ?? '',
      agendaPac: map['agendaPac']?.toInt() ?? 0,
      agendaNome: map['agendaNome'] ?? '',
      agendaTitulo: map['agendaTitulo'] ?? '',
      agendaDesc: map['agendaDesc'] ?? '',
      agendaData: DateTime.fromMillisecondsSinceEpoch(map['agendaData']),
      agendaHora: map['agendaHora'] ?? '',
      agendaCancelado: map['agendaCancelado'] ?? false,
      agendaTratado: map['agendaTratado'] ?? false,
      agendaExcluido: map['agendaExcluido'] ?? false,
      agendaRemarcado: map['agendaRemarcado'] ?? false,
    );
  }

//  String toJson() => json.encode(toMap());

  factory AppEvent.fromJson(String source) =>
      AppEvent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Eventos(agendaUuId: $agendaUuId, agendaPac: $agendaPac, agendaNome: $agendaNome, agendaTitulo: $agendaTitulo, agendaDesc: $agendaDesc, agendaData: $agendaData, agendaHora: $agendaHora, agendaCancelado: $agendaCancelado, agendaTratado: $agendaTratado, agendaExcluido: $agendaExcluido, agendaRemarcado: $agendaRemarcado)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppEvent &&
        other.agendaUuId == agendaUuId &&
        other.agendaPac == agendaPac &&
        other.agendaNome == agendaNome &&
        other.agendaTitulo == agendaTitulo &&
        other.agendaDesc == agendaDesc &&
        other.agendaData == agendaData &&
        other.agendaHora == agendaHora &&
        other.agendaCancelado == agendaCancelado &&
        other.agendaTratado == agendaTratado &&
        other.agendaExcluido == agendaExcluido &&
        other.agendaRemarcado == agendaRemarcado;
  }

  @override
  int get hashCode {
    return agendaUuId.hashCode ^
        agendaPac.hashCode ^
        agendaNome.hashCode ^
        agendaTitulo.hashCode ^
        agendaDesc.hashCode ^
        agendaData.hashCode ^
        agendaHora.hashCode ^
        agendaCancelado.hashCode ^
        agendaTratado.hashCode ^
        agendaExcluido.hashCode ^
        agendaRemarcado.hashCode;
  }
}

class Agenda {
  final String agendaUuId;
  final int agendaPac;
  final String agendaNome;
  final String agendaTitulo;
  final String agendaDesc;
  final DateTime agendaData;
  final String agendaHora;
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
    required this.agendaCancelado,
    required this.agendaTratado,
    required this.agendaExcluido,
    required this.agendaRemarcado,
  });

  factory Agenda.fromJson(Map<String, dynamic> json) => Agenda(
        agendaUuId: json['agendaUuId'],
        agendaPac: json['agendaPac'],
        agendaNome: json['agendaNome'],
        agendaTitulo: json['agendaTitulo'],
        agendaDesc: json['agendaDesc'],
//        DateTime.parse(json["tanggalEvent"])
        agendaData: DateTime.parse(json["agendaData"]),
        agendaHora: json['agendaHora'],
        agendaCancelado: json['agendaCancelado'],
        agendaTratado: json['agendaTratado'],
        agendaExcluido: json['agendaExcluido'],
        agendaRemarcado: json['agendaRemarcado'],
      );

  Map<String, dynamic> toJson() => {
        'agendaUuId': agendaUuId,
        'agendaPac': agendaPac,
        'agendaNome': agendaNome,
        'agendaTitulo': agendaTitulo,
        'agendaDesc': agendaDesc,
        'agendaData': agendaData.millisecondsSinceEpoch,
        'agendaHora': agendaHora,
        'agendaCancelado': agendaCancelado,
        'agendaTratado': agendaTratado,
        'agendaExcluido': agendaExcluido,
        'agendaRemarcado': agendaRemarcado,
      };
}

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

class Event {
  String status;
  String message;
  List<Agenda> data;

  Event({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        status: json["status"],
        message: json["message"],
        data: List<Agenda>.from(json["data"].map((x) => Agenda.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}








/*

class AppEvent {
  final String title;
  final String id;
  final String description;
  final DateTime date;
  final String userId;
  final bool public;
  AppEvent({
    required this.title,
    required this.id,
    required this.description,
    required this.date,
    required this.userId,
    required this.public,
  });

  factory AppEvent.fromDS(String id, Map<String, dynamic> data) {
    // ignore: unnecessary_null_comparison
    return AppEvent(
      title: data['title'],
      id: id,
      description: data['description'],
      date: DateTime.fromMillisecondsSinceEpoch(data['date']),
      userId: data['user_id'],
      public: data['public'],
    );
  }

  factory AppEvent.fromMap(Map<String, dynamic> map) {
    return AppEvent(
      title: map['title'] ?? '',
      id: map['id'] ?? '',
      description: map['description'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      userId: map['userId'] ?? '',
      public: map['public'] ?? false,
    );
  }

  AppEvent copyWith({
    String? title,
    String? id,
    String? description,
    DateTime? date,
    String? userId,
    bool? public,
  }) {
    return AppEvent(
      title: title ?? this.title,
      id: id ?? this.id,
      description: description ?? this.description,
      date: date ?? this.date,
      userId: userId ?? this.userId,
      public: public ?? this.public,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'userId': userId,
      'public': public,
    };
  }

  String toJson() => json.encode(toMap());

  factory AppEvent.fromJson(String source) =>
      AppEvent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppEvent(title: $title, id: $id, description: $description, date: $date, userId: $userId, public: $public)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppEvent &&
        other.title == title &&
        other.id == id &&
        other.description == description &&
        other.date == date &&
        other.userId == userId &&
        other.public == public;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        id.hashCode ^
        description.hashCode ^
        date.hashCode ^
        userId.hashCode ^
        public.hashCode;
  }
}



  AppEvent({
    required this.title,
    required this.id,
    required this.description,
    required this.date,
    required this.userId,
    required this.public,
  });





  AppEvent copyWith({
    String title,
    String id,
    String description,
    DateTime date,
    String userId,
    bool public,
  }) {
    return AppEvent(
      title: title ?? this.title,
      id: id ?? this.id,
      description: description ?? this.description,
      date: date ?? this.date,
      userId: userId ?? this.userId,
      public: public ?? this.public,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'userId': userId,
      'public': public,
    };
  }

  factory AppEvent.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AppEvent(
      title: map['title'],
      id: map['id'],
      description: map['description'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      userId: map['userId'],
      public: map['public'],
    );
  }
  factory AppEvent.fromDS(String id, Map<String, dynamic> data) {
    if (data == null) return null;

    return AppEvent(
      title: data['title'],
      id: id,
      description: data['description'],
      date: DateTime.fromMillisecondsSinceEpoch(data['date']),
      userId: data['user_id'],
      public: data['public'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppEvent.fromJson(String source) =>
      AppEvent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppEvent(title: $title, id: $id, description: $description, date: $date, userId: $userId, public: $public)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AppEvent &&
        o.title == title &&
        o.id == id &&
        o.description == description &&
        o.date == date &&
        o.userId == userId &&
        o.public == public;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        id.hashCode ^
        description.hashCode ^
        date.hashCode ^
        userId.hashCode ^
        public.hashCode;
  }
  */