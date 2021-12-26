import 'dart:developer';
import 'package:supabase/supabase.dart';

const supabaseUrl = 'https://xrhyhsbetlnzksauwrvi.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzODA3NTI4MywiZXhwIjoxOTUzNjUxMjgzfQ.gsz31qxeQ_h6R_93rthZwynvz1i8jNrXLz30JaFprqA';

class Conecta {
  final client = SupabaseClient(supabaseUrl, supabaseKey);

  // Pacientes

  Future updatePaciente(int idPaciente, String cidade) async {
    await client
        .from('pacientes')
        .update({'cidade': cidade})
        .eq('id', idPaciente)
        .execute();
  }

  Future deletePaciente(int idPaciente) async {
    await client.from('pacientes').delete().eq('id', idPaciente).execute();
  }

  Future<List> getAgenda() async {
    log('Leu Agenda 4');
    final response = await client.from('teste').select().execute();
    if (response.error == null) {
      final dataList = response.data as List;
      return (dataList);
    }
    log('Error fetching notes: ${response.error!.message}');
    return [];
  }

  Future cancelAgenda(String agendaUuId, bool situacao) async {
    await client
        .from('teste')
        .update({'agendaExcluido': true, 'agendaCancelado': situacao})
        .eq('agendaUuId', agendaUuId)
        .execute()
        .then((value) => log('ok'));
  }

  Future voltaAgenda() async {
    await client
        .from('teste')
        .update({'agendaExcluido': false, 'agendaCancelado': false})
        .filter('agendaExcluido', 'eq', true)
        .execute()
        .then((value) => log('Volta OK'));
  }
}
