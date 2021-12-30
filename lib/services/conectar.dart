import 'package:nova_agenda/model/model.dart';
import 'package:nova_agenda/services/config.dart';
import 'package:supabase/supabase.dart';
import 'dart:developer';
import '/services/config.dart';

class Conecta {
  final client = SupabaseClient(supabaseUrl, supabaseKey);

  // Pacientes

  Future<List<ClassPaciente>> getAll() async {
    log('Leu Pacientes 1');
    final response = await client
        .from('pacientes')
        .select()
        .order('pacNome', ascending: true)
        .execute();
    if (response.error == null) {
      final dataList = response.data as List;
      return (dataList.map((map) => ClassPaciente.fromJson(map)).toList());
    }
    log('Error fetching notes: ${response.error!.message}');
    return [];
  }

  Future addPaciente(campos) async {
    ClassPaciente pacientes = campos;
    Map<String, dynamic> pacienteJson = pacientes.toJson();
    log(pacienteJson.toString());
    await client
        .from('pacientes')
        .insert(pacienteJson)
        .execute()
        .then((value) => log(value.error.toString()));
  }

  Future updatePaciente(int idPaciente, String cidade) async {
    await client
        .from('pacientes')
        .update({'cidade': cidade})
        .eq('id', idPaciente)
        .execute();
  }

  favoritoPaciente(String pacUuId, bool favorito) async {
//    log(favorito.toString());
    await client
        .from('pacientes')
        .update({'pacFavorito': favorito})
        .eq('pacUuId', pacUuId)
        .execute();
  }

  Future deletePaciente(int idPaciente) async {
    await client.from('pacientes').delete().eq('id', idPaciente).execute();
  }

  // Historico

  Future<List<Historico>> getHistorico() async {
    log('Leu Historico');
    final response = await client
        .from('historico')
        .select()
        .order('createdAt', ascending: false)
        .execute();
    if (response.error == null) {
      final dataListH = response.data as List;
      return (dataListH.map((map) => Historico.fromJson(map)).toList());
    }
    log('Error fetching notes: ${response.error!.message}');
    return [];
  }

  Future delHistorico(int idPaciente) async {
    await client
        .from('historico')
        .delete()
        .eq('hisIdPaciente', idPaciente)
        .execute();
  }

  Future cancelAgenda(String agendaUuId, bool situacao) async {
    await client
        .from('teste')
        .update({'agendaExcluido': true, 'agendaCancelado': situacao})
        .eq('agendaUuId', agendaUuId)
        .execute()
        .then((value) => {}); // log('ok'));
  }

  Future voltaAgenda() async {
    await client
        .from('teste')
        .update({'agendaExcluido': false, 'agendaCancelado': false})
        .filter('agendaExcluido', 'eq', true)
        .execute()
        .then((value) => {}); // log('Resposta ${value.toString()}'));
  }
}
