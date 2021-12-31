import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nova_agenda/services/conectar.dart';
import 'package:nova_agenda/services/config.dart';
import 'package:supabase/supabase.dart';
import '/services/widgets.dart';
import '/model/model.dart';

class Pacientes extends StatefulWidget {
  const Pacientes({Key? key}) : super(key: key);

  @override
  _PacientesState createState() => _PacientesState();
}

int colunas = 1;
bool icone = false;
final client = SupabaseClient(supabaseUrl, supabaseKey);

List<ClassPaciente> lista = [];

class _PacientesState extends State<Pacientes> {
  Conecta conectar = Conecta();

  @override
  void initState() {
    lista = [];
    lerAgora();
    setState(() {
      lista;
    });
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
          ClassPaciente(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarra(context, 'Pacientes'),
      body: ListView.builder(
        itemCount: lista.length,
        itemBuilder: (__, index) {
          return Container(
            height: 65,
            margin: const EdgeInsets.only(
              top: 8,
              left: 10,
              right: 10,
            ),
//            color: Colors.amber,
            child: Slidable(
              groupTag: '1',
              key: const ValueKey(0),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      log('Botão 1');
/*
                                  remarcarAgenda(
                                      context, value[index].agendaUuId);
                                  setState(() {});
*/
                    },
                    backgroundColor: const Color(0xFF66BB6A),
                    foregroundColor: Colors.white,
                    icon: Icons.phone_iphone,
                    label: 'Ligar',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      log('Botão 2');
                    },
                    backgroundColor: const Color(0xFF26A69A),
                    foregroundColor: Colors.white,
                    icon: Icons.calendar_today,
                    label: 'Agendar',
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () => mudaTela(lista, index),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 65,
                  color: Theme.of(context)
                      .primaryColor
                      .withOpacity(.6), // const Color(0xFFD6D6D6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 300,
                            margin: const EdgeInsets.only(left: 10),
                            //                            color: Colors.red,
                            child: Text(
                              lista[index].pacNome,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'RobotoSlab',
                                letterSpacing: .5,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              left: 10,
                              top: 3,
                            ),
                            //                            color: Colors.blue,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.phoneSquareAlt,
                                  size: 15,
                                  color: Colors.teal,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  lista[index].pacFone.toString(),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'RobotoSlab',
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => {
                          mudaFavorito(index),
                        },
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: lista[index].pacFavorito
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    SizedBox(
                                      width: 35,
                                      height: 35,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        // Color(0xFFD6D6D6),
                                        child: FaIcon(
                                          FontAwesomeIcons.solidHeart,
                                          size: 20,
                                          color: Color(0xFF4DB6AC),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : const CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  // Color(0xFFD6D6D6),
                                  child: FaIcon(
                                    FontAwesomeIcons.heart,
                                    size: 20,
                                    color: Colors.teal, // Color(0xFF4DB6AC),
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  mudaFavorito(index) {
    setState(() {
      lista[index].pacFavorito = !lista[index].pacFavorito;
    });
    bool favorito = lista[index].pacFavorito;
    String uuid = lista[index].pacUuId;
    conectar.favoritoPaciente(uuid, favorito);
  }

  mudaTela(lista, int index) {
    log('Vai pra Paciente');
    log(lista[index].pacNome);
  }
}


/*


Container(
            height: 80,
            margin: const EdgeInsets.only(
              top: 5,
              left: 5,
              right: 5,
            ),
//            color: Colors.amber,
            child: Slidable(
              groupTag: '1',
              key: const ValueKey(0),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
/*
                                  remarcarAgenda(
                                      context, value[index].agendaUuId);
                                  setState(() {});
*/
                    },
                    backgroundColor: const Color(0xFF66BB6A),
                    foregroundColor: Colors.white,
                    icon: Icons.phone_iphone,
                    label: 'Ligar',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      log('aqui');
                    },
                    backgroundColor: const Color(0xFF26A69A),
                    foregroundColor: Colors.white,
                    icon: Icons.calendar_today,
                    label: 'Agendar',
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () => mudaTela(lista, index),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 300,
                            margin: const EdgeInsets.only(left: 12),
                            child: Text(
                              lista[index].pacNome,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'RobotoSlab',
                                letterSpacing: .5,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 12),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                const FaIcon(
                                  FontAwesomeIcons.phoneSquareAlt,
                                  size: 15,
                                  color: Colors.teal,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  lista[index].pacFone.toString(),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'RobotoSlab',
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => {
                          mudaFavorito(index),
                        },
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: lista[index].pacFavorito
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    SizedBox(
                                      width: 35,
                                      height: 35,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: FaIcon(
                                          FontAwesomeIcons.solidHeart,
                                          size: 20,
                                          color: Color(0xFF00796B),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: FaIcon(
                                    FontAwesomeIcons.heart,
                                    size: 20,
                                    color: Color(0xFF4DB6AC),
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );







          
          
          
           Container(
            width: MediaQuery.of(context).size.width,
            height: 65,
            color: Colors.amber,
            margin: const EdgeInsets.only(
              top: 8,
              left: 10,
              right: 10,
            ),
            child: Slidable(
              groupTag: '1',
              key: const ValueKey(0),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
/*
                                  remarcarAgenda(
                                      context, value[index].agendaUuId);
                                  setState(() {});
*/
                    },
                    backgroundColor: const Color(0xFF7BC043),
                    foregroundColor: Colors.white,
                    icon: Icons.calendar_today_rounded,
                    label: 'Remarcar',
                  ),
                  SlidableAction(
                    onPressed: (context) async {
/*
                    await apagarAgenda(jojo[index].agendaUuId);
                    refaz(selectedCalendarDate);
                  */
                    },
                    backgroundColor: const Color(0xFF0392CF),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Cancelar',
                  ),
                ],
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 65,
                color: const Color(0xFFD6D6D6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 10,
                          height: 65,
                          color: Colors.red,
                          child: ListTile(
                            dense: true,
                            onTap: () => {log('clicou')},
                            title: Text(
                              lista[index].pacNome,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              lista[index].pacFone.toString(),
                            ),
                            trailing: GestureDetector(
                              onTap: () => {
                                mudaFavorito(index),
                              },
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: lista[index].pacFavorito
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          SizedBox(
                                            width: 35,
                                            height: 35,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: FaIcon(
                                                FontAwesomeIcons.solidHeart,
                                                size: 20,
                                                color: Color(0xFF00796B),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: FaIcon(
                                          FontAwesomeIcons.heart,
                                          size: 20,
                                          color: Color(0xFF4DB6AC),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
          */



          
                

