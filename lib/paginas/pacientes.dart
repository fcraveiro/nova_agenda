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
late Future useFuture;
bool icone = false;

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
                        trailing: favorito(post.pacUuId, !post.pacFavorito),
                      ),
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
//    log(uuid.toString());
//    log(favorito.toString());
    return GestureDetector(
      onTap: () => {
        log(favorito.toString()),
        log('aqi'),
        conectar.favoritoPaciente(uuid, favorito),
        setState(() {
          favorito;
        })
      },
      child: SizedBox(
        width: 40,
        height: 40,
        child: CircleAvatar(
          child: favorito
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


*/