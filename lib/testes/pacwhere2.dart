import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nova_agenda/paginas/setup.dart';
import 'package:nova_agenda/services/conectar.dart';
import 'package:nova_agenda/services/config.dart';
import 'package:supabase/supabase.dart';
import '/model/model.dart';

class PacWhere2 extends StatefulWidget {
  const PacWhere2({Key? key}) : super(key: key);

  @override
  _PacWhere2State createState() => _PacWhere2State();
}

final client = SupabaseClient(supabaseUrl, supabaseKey);
final TextEditingController _nomeController = TextEditingController();

List<ClassPaciente> lista = [];
int selecionados = 0;

class _PacWhere2State extends State<PacWhere2> {
  Conecta conectar = Conecta();

  @override
  void initState() {
    lista = [];
    lerAgora();
    setState(() {
      lista;
      filteredPacientes = lista;
    });
    _nomeController.text = '';
    super.initState();
  }

  Future<List<ClassPaciente>> lerAgora() async {
    log('Lendo ....');
    final response = await client
        .from('pacientes')
        .select()
//        .order('pacNome', ascending: true)
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
      appBar: AppBar(
        elevation: 4,
        title: Text('Pacientes ($selecionados)'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Setup(),
                ),
              ),
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        height: 75,
                        margin: const EdgeInsets.all(0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 60,
                              width: 400,
                              padding: const EdgeInsets.only(top: 10),
                              margin: const EdgeInsets.only(top: 5),
                              child: TextField(
                                controller: _nomeController,
//                                maxLength: 30,
                                cursorColor: Colors.grey,
                                onChanged: (value) {
                                  pesqNome(value);
                                },
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () => {
                                      _nomeController.clear(),
                                      mostraTodos(),
                                    },
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.white,
                                    ),
                                  ),
                                  labelText: "Nome",
                                  labelStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF757575),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF757575),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  hoverColor: Colors.red,
                                  fillColor: Colors.blue,
                                  focusColor: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () => {
                          limpaPesquisa(),
                          pesqFavorito(),
                          _nomeController.clear(),
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyan.shade800),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 10),
                          ),
                        ),
                        child: Row(
                          children: const [
                            FaIcon(
                              FontAwesomeIcons.solidHeart,
                              color: Colors.white,
                              size: 14,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Favoritos'),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => {
                          limpaPesquisa(),
                          pesqTratando(),
                          _nomeController.clear(),
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyan.shade800),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 10),
                          ),
                        ),
                        child: Row(
                          children: const [
                            FaIcon(
                              FontAwesomeIcons.tooth,
                              color: Colors.white,
                              size: 14,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Tratando'),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => {
                          mostraTodos(),
                          _nomeController.clear(),
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyan.shade800),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 10),
                          ),
                        ),
                        child: Row(
                          children: const [
                            FaIcon(
                              FontAwesomeIcons.windowClose,
                              color: Colors.white,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Limpar'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: exibeResultado(),
          ),
        ],
      ),
    );
  }

  List filteredPacientes = [];

  pesqNome(value) {
    filteredPacientes = lista
        .where((n) => n.pacNome.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {
      selecionados = filteredPacientes.length;
      filteredPacientes;
    });
  }

  limpaPesquisa() {
    setState(() {
      filteredPacientes = [];
    });
  }

  mostraTodos() {
    setState(() {
      filteredPacientes = lista;
      selecionados = lista.length;
    });
  }

  pesqFavorito() {
    setState(() {
      filteredPacientes = lista.where((n) => n.pacFavorito == true).toList();
      selecionados = filteredPacientes.length;
      filteredPacientes;
    });
  }

  pesqTratando() {
    setState(() {
      filteredPacientes = lista.where((n) => n.pacTratando == true).toList();
      selecionados = filteredPacientes.length;
      filteredPacientes;
    });
  }

  exibeResultado() {
    if (filteredPacientes.isEmpty) {
      return const Text('vazia');
    }
    return ListView.builder(
      itemCount: filteredPacientes.length,
      itemBuilder: (__, index) {
        return Container(
          height: 65,
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
                color: const Color(0xFFD6D6D6),
/*                  color: Theme.of(context)
                      .primaryColor
                      .withOpacity(.6), // const Color(0xFFD6D6D6),
*/
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
                            filteredPacientes[index].pacNome,
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
                                filteredPacientes[index].pacFone.toString(),
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
                        height: 65,
                        child: filteredPacientes[index].pacFavorito
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
                                        color: Colors.teal,
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
    );
  }

  mudaFavorito(index) {
    setState(() {
      filteredPacientes[index].pacFavorito =
          !filteredPacientes[index].pacFavorito;
    });
    bool favorito = filteredPacientes[index].pacFavorito;
    String uuid = filteredPacientes[index].pacUuId;
    conectar.favoritoPaciente(uuid, favorito);
  }

  mudaTela(lista, int index) {
    log('Vai pra Paciente');
    log(filteredPacientes[index].pacNome);
  }
}
