import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  @override
  void initState() {
    lerAgora();
    setState(() {
      lista;
    });
    super.initState();
  }

  Future<List<ClassPaciente>> lerAgora() async {
    final response = await client
        .from('pacientes')
        .select()
        .order('pacNome', ascending: true)
        .execute();
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
          return ListTile(
            title: Text(
              lista[index].pacNome.toString(),
              style: const TextStyle(
                  fontSize: 13,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2),
            ),
            subtitle: Text(
              lista[index].pacFone.toString(),
              style:
                  const TextStyle(fontFamily: 'RobotoSlab', letterSpacing: 0.8),
            ),
//                          onTap: () => teste(post),
            trailing: GestureDetector(
              onTap: () => {
//                log(lista[index].pacFavorito.toString()),
//                setState(
//                  () {
//                                favorito(post.pacUuId, !post.pacFavorito);
//                                conectar.favoritoPaciente(
//                                    post.pacUuId, !post.pacFavorito);
//                  },
//                )
              },
              child: SizedBox(
                width: 35,
                height: 35,
//                              color: Colors.amber,
                child: CircleAvatar(
                  child: lista[index].pacFavorito
                      ? const FaIcon(
                          FontAwesomeIcons.solidHeart,
                          size: 20,
                          color: Colors.teal,
                        )
                      : const FaIcon(
                          FontAwesomeIcons.heart,
                          size: 20,
                          color: Colors.teal,
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}



/*


import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/services/constantes.dart';
import '/services/widgets.dart';
import '/model/model.dart';
import '/services/conectar.dart';

class Pacientes extends StatefulWidget {
  const Pacientes({Key? key}) : super(key: key);

  @override
  _PacientesState createState() => _PacientesState();
}

int colunas = 1;

class _PacientesState extends State<Pacientes> {
  Conecta conectar = Conecta();

  @override
  void initState() {
    super.initState();
    if (box.read('colunas') == null) {
      box.write('colunas', 2);
      log('Colunas Pacientes Vazio');
    }
    colunas = box.read('colunas');
    log('Colunas Pacientes $colunas');
//    conectar.getHistorico();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarra(context, 'Pacientes'),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: FutureBuilder(
          future: conectar.getAll(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ClassPaciente>> snapshot) {
            if (snapshot.hasData) {
              List<ClassPaciente>? posts = snapshot.data;

              return ListView(
                children: posts!
                    .map(
                      (ClassPaciente post) => ListTile(
                          title: Text(
                            post.pacNome.toString(),
                            style: const TextStyle(
                                fontSize: 13,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.2),
                          ),
                          subtitle: Text(
                            post.pacFone.toString(),
                            style: const TextStyle(
                                fontFamily: 'RobotoSlab', letterSpacing: 0.8),
                          ),
                          /*
                        leading: const SizedBox(
                          width: 25,
                          height: 25,
                          child:
                              CircleAvatar(
                            child: FaIcon(
                              FontAwesomeIcons.solidHeart,
                              size: 14,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                        */
                          onTap: () => teste(post),
                          trailing: GestureDetector(
                            onTap: () => {
                              log(post.pacFavorito.toString()),
                              setState(() {
//                                favorito(post.pacUuId, !post.pacFavorito);
                                conectar.favoritoPaciente(
                                    post.pacUuId, !post.pacFavorito);
                              })
                            },
                            child: SizedBox(
                              width: 40,
                              height: 40,
//                              color: Colors.amber,
                              child: CircleAvatar(
                                child: post.pacFavorito
                                    ? const FaIcon(
                                        FontAwesomeIcons.solidHeart,
                                        size: 20,
                                        color: Colors.teal,
                                      )
                                    : const FaIcon(
                                        FontAwesomeIcons.heart,
                                        size: 20,
                                        color: Colors.teal,
                                      ),
                              ),
                            ),
                          )),
                    )
                    .toList(),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      persistentFooterButtons: const [
        Icon(Icons.settings),
        SizedBox(width: 5),
        Icon(Icons.exit_to_app),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  teste(ClassPaciente post) {
//    Navigator.of(context)
//        .push(MaterialPageRoute(
//            builder: (context) => Paciente(
//                  post: post,
//                )))
//        .then((_) => setState(() {}));
//  }
  }

  favorito(String uuid, bool favorito) {
    conectar.favoritoPaciente(uuid, favorito);
  }
}

      persistentFooterButtons: const [
        Icon(Icons.settings),
        SizedBox(width: 5),
        Icon(Icons.exit_to_app),
        SizedBox(
          width: 10,
        ),
      ],

*/


/*

FutureBuilder(
          future: conectar.getAll(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ClassPaciente>> snapshot) {
            if (snapshot.hasData) {
//              log(snapshot.toString());
              List<ClassPaciente>? posts = snapshot.data;
              return ListView(
                children: posts!
                    .map(
                      (ClassPaciente post) => ListTile(
                        title: Text(
                          post.pacNome.toString(),
                          style: const TextStyle(
                              fontSize: 13,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2),
                        ),
                        subtitle: Text(
                          post.pacFone.toString(),
                          style: const TextStyle(
                              fontFamily: 'RobotoSlab', letterSpacing: 0.8),
                        ),
                        /*
                        leading: const SizedBox(
                          width: 25,
                          height: 25,
                          child:
                              CircleAvatar(
                            child: FaIcon(
                              FontAwesomeIcons.solidHeart,
                              size: 14,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                        */
                        onTap: () => teste(post),
                        trailing: GestureDetector(
                          onTap: () => favorito(post.pacUuId, post.pacFavorito),
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: CircleAvatar(
                              child: post.pacFavorito
                                  ? const FaIcon(
                                      FontAwesomeIcons.solidHeart,
                                      size: 20,
                                      color: Colors.teal,
                                    )
                                  : const FaIcon(
                                      FontAwesomeIcons.heart,
                                      size: 20,
                                      color: Colors.teal,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        */


