import 'package:nova_agenda/services/config.dart';
import 'package:supabase/supabase.dart';

class Conecta {
  final client = SupabaseClient(supabaseUrl, supabaseKey);

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
