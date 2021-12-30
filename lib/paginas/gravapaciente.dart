import 'package:flutter/material.dart';
import 'package:nova_agenda/services/widgets.dart';
import '/services/constantes.dart';
import '/model/model.dart';
import '/services/conectar.dart';

class GravaPaciente extends StatefulWidget {
  const GravaPaciente({Key? key, required this.form}) : super(key: key);
  final ClassPaciente form;
  @override
  _MostraFormPacienteState createState() => _MostraFormPacienteState();
}

bool isZap = true;

class _MostraFormPacienteState extends State<GravaPaciente> {
  Conecta conectar = Conecta();

  @override
  Widget build(BuildContext context) {
    ClassPaciente form = widget.form;

    return Scaffold(
      appBar: appBarra(context, 'Pacientes'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ' Confira os Dados Digitados',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 18,
                      color: kFont.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              estilo('  Nome  ', form.pacNome),
              estilo('  Endereço  ', form.pacEnde),
              estilo('  Cidade  ', form.pacCity),
              estilo('  Estado  ', form.pacEst),
              estilo('  Cep  ', form.pacCep),
              estilo2('  Telefone  ', form.pacFone, form.pacZap1),
              estilo2('  Celular  ', form.pacCel, form.pacZap2),
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.greenAccent, // background
                        onPrimary: kFont, // foreground
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Editar'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kAccent, // background
                        onPrimary: kFont, // foreground
                      ),
                      onPressed: () {
                        _showToast(context);
                        conectar.addPaciente(form);
                        Navigator.of(context).pop('aaa');
                      },
                      child: const Text('Gravar Paciente'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  estilo(String descricao, campo) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 55,
      child: Stack(
        children: [
          Positioned(
            top: 9,
            child: Container(
              width: MediaQuery.of(context).size.width - 50,
              height: 40,
              margin: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.blue.shade400,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      campo.toString(),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 16,
                        color: kFont,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 2,
            left: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    descricao,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      backgroundColor: kBackGround,
                      fontSize: 12,
                      color: Colors.blue.shade500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  estilo2(descricao, var campo, iszap) {
    bool iszap2 = false;
    if (iszap == true) {
      iszap2 = true;
    } else {
      iszap2 = false;
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 55,
      margin: const EdgeInsets.only(top: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 20,
                height: 55,
                child: Stack(
                  children: [
                    Positioned(
                      top: 9,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 50,
                        height: 40,
                        margin: const EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.blue.shade400,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                campo.toString(),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: kFont,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 2,
                      left: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              descricao,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                backgroundColor: kBackGround,
                                fontSize: 12,
                                color: Colors.blue.shade500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2 - 40,
                height: 55,
                margin: const EdgeInsets.only(right: 30),
//                color: Colors.amber,
                child: Stack(
                  children: [
                    Positioned(
                      top: 9,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 50,
                        height: 40,
                        margin: const EdgeInsets.only(left: 5),
//                        color: Colors.teal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: Text(
                                'Whatsapp', //campo,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: kFont,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: iszap2
                                  ? const Icon(Icons.check_box,
                                      color: Colors.green)
                                  : const Icon(Icons.check_box_outline_blank,
                                      color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      const SnackBar(
        elevation: 10,
        backgroundColor: kAccent,
        duration: Duration(seconds: 2),
        content: Text(
          'Aguarde Salvando !!',
          style: TextStyle(
            fontSize: 20,
            color: kFont,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
