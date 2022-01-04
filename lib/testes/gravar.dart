import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:nova_agenda/services/conectar.dart';
import 'package:nova_agenda/services/config.dart';
import 'package:supabase/supabase.dart';
import '/model/model.dart';

class Gravar extends StatefulWidget {
  const Gravar({Key? key}) : super(key: key);

  @override
  _GravarState createState() => _GravarState();
}

final client = SupabaseClient(supabaseUrl, supabaseKey);
final TextEditingController _nomeController = TextEditingController();
List<Copia> lista = [];
int selecionados = 0;
int conta = 0;

class _GravarState extends State<Gravar> {
  Conecta conectar = Conecta();

  @override
  void initState() {
    lista = [];
    lerAgora();
    setState(() {});
    _nomeController.text = '';
    super.initState();
  }

  Future<List<ClassPaciente>> lerAgora() async {
    log('Lendo ....');
    final response = await client
        .from('pacientes')
        .select()
        .order('pacNome', ascending: true)
        .execute();
    log(lista.toString());
    if (response.error == null) {
      final dataList = response.data as List;
      log(dataList.length.toString());
      for (var i = 0; i < dataList.length; i++) {
        var evento = (ClassPaciente.fromJson(dataList[i]));
        lista.add(
          Copia(
            pacUuId: evento.pacUuId,
            pacId: evento.pacId,
            pacNome: evento.pacNome,
            pacEnde: evento.pacEnde,
            pacCity: evento.pacCity,
            pacEst: evento.pacEst,
            pacCep: evento.pacCep,
            pacFone: evento.pacFone,
            pacCel: evento.pacCel,
            pacZap1: evento.pacZap1,
            pacZap2: evento.pacZap2,
            pacFavorito: evento.pacFavorito,
            pacTratando: evento.pacTratando,
            pacAviso1: evento.pacAviso1,
            pacAviso2: evento.pacAviso2,
            pacAviso3: evento.pacAviso3,
            pacAviso4: evento.pacAviso4,
            pacAviso5: evento.pacAviso5,
            pacAviso6: evento.pacAviso6,
          ),
        );
        setState(() {
          lista;
        });
      }
    }
    return [];
  }

  ida() async {
    for (var i = 0; i < lista.length; i++) {
      var evento = (lista[i]);
      await Future.delayed(const Duration(milliseconds: 100));
      log(i.toString());
      setState(() {});
      conectar.addPaciente2(evento);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: Text('Pacientes ($selecionados)'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => {
              ida(),
            },
            icon: const Icon(
              Icons.menu,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 130,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

/*
  mudaFavorito(index) {
    setState(() {
      filteredPacientes[index].pacFavorito =
          !filteredPacientes[index].pacFavorito;
    });
    bool favorito = filteredPacientes[index].pacFavorito;
    String uuid = filteredPacientes[index].pacUuId;
    conectar.favoritoPaciente(uuid, favorito);
  }
*/

}
