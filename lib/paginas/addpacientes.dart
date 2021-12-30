import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:nova_agenda/services/widgets.dart';
import '../../services/constantes.dart';
import '/model/model.dart';
import 'package:via_cep_flutter/via_cep_flutter.dart';
import 'gravapaciente.dart';

class AddPaciente extends StatefulWidget {
  const AddPaciente({Key? key}) : super(key: key);

  @override
  _FormTesteState createState() => _FormTesteState();
}

final formPaciente = ClassPaciente(
  pacUuId: '',
  pacId: 0,
  pacNome: '',
  pacEnde: '',
  pacCity: '',
  pacEst: '',
  pacCep: 0,
  pacFone: 0,
  pacCel: 0,
  pacZap1: false,
  pacZap2: false,
  pacFavorito: false,
  pacTratando: false,
  pacAviso1: false,
  pacAviso2: false,
  pacAviso3: false,
  pacAviso4: false,
  pacAviso5: false,
  pacAviso6: false,
);

var maskFormatterCep =
    MaskTextInputFormatter(mask: '########', filter: {"#": RegExp(r'[0-9]')});
var maskFormatterFone = MaskTextInputFormatter(mask: "(##) #########");

class _FormTesteState extends State<AddPaciente> {
  final formKey = GlobalKey<FormState>(); //key for form
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _endeController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();

  var isWhats1 = false;
  var isWhats2 = false;

  @override
  void initState() {
    super.initState();
    limparCampos();
  }

  void limparCampos() {
    setState(() {
      _nomeController.text = '';
      _endeController.text = '';
      _cidadeController.text = '';
      _estadoController.text = '';
      _cepController.text = '';
      _telefoneController.text = '';
      _celularController.text = '';
      isWhats1 = false;
      isWhats2 = false;
    });
  }

  void gravarPaciente() async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => GravaPaciente(
          form: formPaciente,
        ),
        fullscreenDialog: true,
      ),
    );
    if (result != null) {
      limparCampos();
      log(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBarra(context, 'Pacientes'),
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            reverse: true,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 32, right: 40),
                child: Form(
                  key: formKey, //key for form
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),

                      const Text(
                        "Cadastro de Pacientes",
                        style: TextStyle(
                          fontSize: 24,
                          color: kFontLight,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      TextFormField(
                        controller: _nomeController,
                        maxLength: 40,
                        decoration: const InputDecoration(
                          counterText: '',
                          labelText: 'Nome',
                          labelStyle: TextStyle(
                            color: Color(0xFF6200EE),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Nome em Branco";
                          } else {
                            setState(() {
                              //log'Nome ok');
                              formPaciente.pacNome = value;
                            });
                            return null;
                          }
                        },
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFormField(
                            controller: _cepController,
                            inputFormatters: [maskFormatterCep],
                            keyboardType: TextInputType.number,
                            maxLength: 9,
                            decoration: InputDecoration(
                              counterText: '',
                              labelText: 'Cep',
                              labelStyle: const TextStyle(
                                color: Color(0xFF6200EE),
                              ),
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width / 4,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "CEP Vazio";
                              } else if (value.length < 8) {
                                return "CEP Incompleto";
                              } else {
                                setState(() {
                                  //log'Cep ok');

                                  var campo = int.parse(value);
                                  formPaciente.pacCep = campo;
                                  //logcampo.toString());
                                });
                                return null;
                              }
                            },
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.greenAccent, // background
                              onPrimary: kFont, // foreground
                            ),
                            onPressed: () => {
                              if (_cepController.text.length == 8)
                                {
                                  viacep(_cepController.text),
                                },
                            },
                            child: const Text('Consultar por Cep'),
                          ),
                        ],
                      ),

                      TextFormField(
                        controller: _endeController,
                        maxLength: 40,
                        decoration: const InputDecoration(
                          counterText: '',
                          labelText: 'Endereço',
                          labelStyle: TextStyle(
                            color: Color(0xFF6200EE),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Endereço em Branco";
                          } else {
                            setState(() {
                              //log'Endereço ok');
                              formPaciente.pacEnde = value;
                            });
                            return null;
                          }
                        },
                      ),

                      TextFormField(
                        controller: _cidadeController,
                        maxLength: 40,
                        decoration: const InputDecoration(
                          counterText: '',
                          labelText: 'Cidade',
                          labelStyle: TextStyle(
                            color: Color(0xFF6200EE),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Cidade em Branco";
                          } else {
                            setState(() {
                              //log'Cidade ok');
                              formPaciente.pacCity = value;
                            });
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        controller: _estadoController,
                        maxLength: 02,
                        decoration: const InputDecoration(
                          counterText: '',
                          labelText: 'Estado',
                          labelStyle: TextStyle(
                            color: Color(0xFF6200EE),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Estado em Branco";
                          } else {
                            setState(() {
                              //log'Estado ok');
                              formPaciente.pacEst = value;
                            });
                            return null;
                          }
                        },
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFormField(
                            controller: _telefoneController,
                            inputFormatters: [maskFormatterFone],
                            maxLength: 15,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counterText: '',
                              labelText: 'Telefone',
                              labelStyle: const TextStyle(
                                color: Color(0xFF6200EE),
                              ),
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width / 2 - 50,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  value.length == 13 ||
                                  value.length == 14) {
                                setState(() {
                                  //log'Telefone ok');
                                  final result = value.replaceAll(
                                      RegExp('[^A-Za-z0-9]'), '');
                                  formPaciente.pacFone = int.parse(result);
                                  //logresult);
                                });
                                return null;
                              } else {
                                return "Telefone poucos numeros";
                              }
                            },
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2 - 50,
                            margin: const EdgeInsets.only(top: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: isWhats1,
                                  checkColor: Colors.white,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        if (value != null) isWhats1 = value;
                                        value;
                                        //logvalue.toString());
                                      },
                                    );
                                  },
                                ),
                                Text(
                                  'WhatsApp ?',
                                  style: TextStyle(color: Colors.blue.shade900),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFormField(
                            controller: _celularController,
                            inputFormatters: [maskFormatterFone],
                            maxLength: 15,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counterText: '',
                              labelText: 'Celular',
                              labelStyle: const TextStyle(
                                color: Color(0xFF6200EE),
                              ),
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width / 2 - 50,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value.length == 14) {
                                setState(() {
                                  //log'Celular ok');
                                  final result = value.replaceAll(
                                      RegExp('[^A-Za-z0-9]'), '');
                                  formPaciente.pacCel = int.parse(result);
                                });
                                return null;
                              } else {
                                return "Telefone poucos numeros";
                              }
                            },
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2 - 50,
                            margin: const EdgeInsets.only(top: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: isWhats2,
                                  checkColor: Colors.white,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        if (value != null) isWhats2 = value;
                                        value;
                                        //logvalue.toString());
                                      },
                                    );
                                  },
                                ),
                                Text(
                                  'WhatsApp ?',
                                  style: TextStyle(color: Colors.blue.shade900),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      ///////////////////////////////////////////////////////////////////////////

                      const SizedBox(
                        height: 30,
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
                              child: const Text('Cancelar'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: kAccent, // background
                                    onPrimary: kFont, // foreground
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      //                                  formPaciente.nome = _nomeController.text;
                                      //                                  formPaciente.ende = _endeController.text;
                                      //                                  formPaciente.cidade = _cidadeController.text;
                                      //                                  formPaciente.estado = _estadoController.text;
                                      //                                  formPaciente.cep = _cepController.text;
                                      //                                  formPaciente.fone = _telefoneController.text;
                                      //                                  formPaciente.celular =
                                      //                                     _celularController.text;

                                      formPaciente.pacZap1 = isWhats1;
                                      formPaciente.pacZap2 = isWhats2;

                                      //logformPaciente.toString());
                                      //log'Nome ${formPaciente.pacNome}');
                                      //log'Endereco ${formPaciente.pacEnde}');
                                      //log'Cidade ${formPaciente.pacCity}');
                                      //log'Estado ${formPaciente.pacEst}');
                                      //log'CEP ${formPaciente.pacCep}');
                                      //log'Fone ${formPaciente.pacFone}');
                                      //log'Celular ${formPaciente.pacCel}');
                                      //log'WhatsApp 1 ${formPaciente.pacZap1}');
                                      //log'WhatsApp 2 ${formPaciente.pacZap2}');

                                      //log_nomeController.text);
                                      //log_endeController.text);
                                      //log_cidadeController.text);
                                      //log_estadoController.text);
                                      //log_cepController.text);
                                      //log_telefoneController.text);
                                      //log_celularController.text);
                                      //logisWhats1.toString());
                                      //logisWhats2.toString());
                                      gravarPaciente();
                                      //                                  gravarPaciente(context, formPaciente);
                                    }
                                  },
                                  child: const Text('Enviar'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  viacep(String cep) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        elevation: 10,
        backgroundColor: kAccent,
        content: Text(
          'Aguarde : Procurando Cep !!',
          style: TextStyle(
            fontSize: 18,
            color: kFont,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

    final result = await readAddressByCep(cep);
    setState(
      () {
        if (result.isEmpty) {
          _endeController.text = '';
          _cidadeController.text = '';
          _estadoController.text = '';
          //logformPaciente.toString());
        } else {
          _endeController.text = result['street'];
          _cidadeController.text = result['city'];
          _estadoController.text = result['state'];
          _cepController.text = result['cep'];
          //logformPaciente.toString());
        }
      },
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}

gravarPaciente3(context, form) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => GravaPaciente(
        form: form,
      ),
    ),
  );
}

/*

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:nova_agenda/services/widgets.dart';
import '../../services/constantes.dart';
import '/model/model.dart';
import 'package:via_cep_flutter/via_cep_flutter.dart';
import 'gravapaciente.dart';

class AddPaciente extends StatefulWidget {
  const AddPaciente({Key? key}) : super(key: key);

  @override
  _FormTesteState createState() => _FormTesteState();
}

final formPaciente = ClassPaciente(
  pacUuId: '',
  pacId: 0,
  pacNome: '',
  pacEnde: '',
  pacCity: '',
  pacEst: '',
  pacCep: 0,
  pacFone: 0,
  pacCel: 0,
  pacZap1: false,
  pacZap2: false,
  pacFavorito: false,
  pacTratando: false,
  pacAviso1: false,
  pacAviso2: false,
  pacAviso3: false,
  pacAviso4: false,
  pacAviso5: false,
  pacAviso6: false,
);

var maskFormatterCep =
    MaskTextInputFormatter(mask: '########', filter: {"#": RegExp(r'[0-9]')});
var maskFormatterFone = MaskTextInputFormatter(mask: "(##) #########");

class _FormTesteState extends State<AddPaciente> {
  final formKey = GlobalKey<FormState>(); //key for form
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _endeController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();

  var isWhats1 = false;
  var isWhats2 = false;

  @override
  void initState() {
    super.initState();
    limparCampos();
  }

  void limparCampos() {
    setState(() {
      _nomeController.text = '';
      _endeController.text = '';
      _cidadeController.text = '';
      _estadoController.text = '';
      _cepController.text = '';
      _telefoneController.text = '';
      _celularController.text = '';
      isWhats1 = false;
      isWhats2 = false;
    });
  }

  void gravarPaciente() async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => GravaPaciente(
          form: formPaciente,
        ),
        fullscreenDialog: true,
      ),
    );
    if (result != null) {
      limparCampos();
      log(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBarra(context, 'Pacientes'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 32, right: 40),
            child: Form(
              key: formKey, //key for form
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),

                  const Text(
                    "Cadastro de Pacientes",
                    style: TextStyle(
                      fontSize: 24,
                      color: kFontLight,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  TextFormField(
                    controller: _nomeController,
                    maxLength: 40,
                    decoration: const InputDecoration(
                      counterText: '',
                      labelText: 'Nome',
                      labelStyle: TextStyle(
                        color: Color(0xFF6200EE),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Nome em Branco";
                      } else {
                        setState(() {
                          //log'Nome ok');
                          formPaciente.pacNome = value;
                        });
                        return null;
                      }
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextFormField(
                        controller: _cepController,
                        inputFormatters: [maskFormatterCep],
                        keyboardType: TextInputType.number,
                        maxLength: 9,
                        decoration: InputDecoration(
                          counterText: '',
                          labelText: 'Cep',
                          labelStyle: const TextStyle(
                            color: Color(0xFF6200EE),
                          ),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width / 4,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "CEP Vazio";
                          } else if (value.length < 8) {
                            return "CEP Incompleto";
                          } else {
                            setState(() {
                              //log'Cep ok');

                              var campo = int.parse(value);
                              formPaciente.pacCep = campo;
                              //logcampo.toString());
                            });
                            return null;
                          }
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.greenAccent, // background
                          onPrimary: kFont, // foreground
                        ),
                        onPressed: () => {
                          if (_cepController.text.length == 8)
                            {
                              viacep(_cepController.text),
                            },
                        },
                        child: const Text('Consultar por Cep'),
                      ),
                    ],
                  ),

                  TextFormField(
                    controller: _endeController,
                    maxLength: 40,
                    decoration: const InputDecoration(
                      counterText: '',
                      labelText: 'Endereço',
                      labelStyle: TextStyle(
                        color: Color(0xFF6200EE),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Endereço em Branco";
                      } else {
                        setState(() {
                          //log'Endereço ok');
                          formPaciente.pacEnde = value;
                        });
                        return null;
                      }
                    },
                  ),

                  TextFormField(
                    controller: _cidadeController,
                    maxLength: 40,
                    decoration: const InputDecoration(
                      counterText: '',
                      labelText: 'Cidade',
                      labelStyle: TextStyle(
                        color: Color(0xFF6200EE),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Cidade em Branco";
                      } else {
                        setState(() {
                          //log'Cidade ok');
                          formPaciente.pacCity = value;
                        });
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _estadoController,
                    maxLength: 02,
                    decoration: const InputDecoration(
                      counterText: '',
                      labelText: 'Estado',
                      labelStyle: TextStyle(
                        color: Color(0xFF6200EE),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Estado em Branco";
                      } else {
                        setState(() {
                          //log'Estado ok');
                          formPaciente.pacEst = value;
                        });
                        return null;
                      }
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextFormField(
                        controller: _telefoneController,
                        inputFormatters: [maskFormatterFone],
                        maxLength: 15,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: '',
                          labelText: 'Telefone',
                          labelStyle: const TextStyle(
                            color: Color(0xFF6200EE),
                          ),
                          constraints: BoxConstraints(
                            maxWidth:
                                MediaQuery.of(context).size.width / 2 - 50,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty ||
                              value.length == 13 ||
                              value.length == 14) {
                            setState(() {
                              //log'Telefone ok');
                              final result =
                                  value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
                              formPaciente.pacFone = int.parse(result);
                              //logresult);
                            });
                            return null;
                          } else {
                            return "Telefone poucos numeros";
                          }
                        },
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 50,
                        margin: const EdgeInsets.only(top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: isWhats1,
                              checkColor: Colors.white,
                              onChanged: (value) {
                                setState(
                                  () {
                                    if (value != null) isWhats1 = value;
                                    value;
                                    //logvalue.toString());
                                  },
                                );
                              },
                            ),
                            Text(
                              'WhatsApp ?',
                              style: TextStyle(color: Colors.blue.shade900),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextFormField(
                        controller: _celularController,
                        inputFormatters: [maskFormatterFone],
                        maxLength: 15,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: '',
                          labelText: 'Celular',
                          labelStyle: const TextStyle(
                            color: Color(0xFF6200EE),
                          ),
                          constraints: BoxConstraints(
                            maxWidth:
                                MediaQuery.of(context).size.width / 2 - 50,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value.length == 14) {
                            setState(() {
                              //log'Celular ok');
                              final result =
                                  value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
                              formPaciente.pacCel = int.parse(result);
                            });
                            return null;
                          } else {
                            return "Telefone poucos numeros";
                          }
                        },
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 50,
                        margin: const EdgeInsets.only(top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: isWhats2,
                              checkColor: Colors.white,
                              onChanged: (value) {
                                setState(
                                  () {
                                    if (value != null) isWhats2 = value;
                                    value;
                                    //logvalue.toString());
                                  },
                                );
                              },
                            ),
                            Text(
                              'WhatsApp ?',
                              style: TextStyle(color: Colors.blue.shade900),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  ///////////////////////////////////////////////////////////////////////////

                  const SizedBox(
                    height: 30,
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
                          child: const Text('Cancelar'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: kAccent, // background
                                onPrimary: kFont, // foreground
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
//                                  formPaciente.nome = _nomeController.text;
//                                  formPaciente.ende = _endeController.text;
//                                  formPaciente.cidade = _cidadeController.text;
//                                  formPaciente.estado = _estadoController.text;
//                                  formPaciente.cep = _cepController.text;
//                                  formPaciente.fone = _telefoneController.text;
//                                  formPaciente.celular =
//                                     _celularController.text;

                                  formPaciente.pacZap1 = isWhats1;
                                  formPaciente.pacZap2 = isWhats2;

                                  //logformPaciente.toString());
                                  //log'Nome ${formPaciente.pacNome}');
                                  //log'Endereco ${formPaciente.pacEnde}');
                                  //log'Cidade ${formPaciente.pacCity}');
                                  //log'Estado ${formPaciente.pacEst}');
                                  //log'CEP ${formPaciente.pacCep}');
                                  //log'Fone ${formPaciente.pacFone}');
                                  //log'Celular ${formPaciente.pacCel}');
                                  //log'WhatsApp 1 ${formPaciente.pacZap1}');
                                  //log'WhatsApp 2 ${formPaciente.pacZap2}');

                                  //log_nomeController.text);
                                  //log_endeController.text);
                                  //log_cidadeController.text);
                                  //log_estadoController.text);
                                  //log_cepController.text);
                                  //log_telefoneController.text);
                                  //log_celularController.text);
                                  //logisWhats1.toString());
                                  //logisWhats2.toString());
                                  gravarPaciente();
//                                  gravarPaciente(context, formPaciente);
                                }
                              },
                              child: const Text('Enviar'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  viacep(String cep) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        elevation: 10,
        backgroundColor: kAccent,
        content: Text(
          'Aguarde : Procurando Cep !!',
          style: TextStyle(
            fontSize: 18,
            color: kFont,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

    final result = await readAddressByCep(cep);
    setState(
      () {
        if (result.isEmpty) {
          _endeController.text = '';
          _cidadeController.text = '';
          _estadoController.text = '';
          //logformPaciente.toString());
        } else {
          _endeController.text = result['street'];
          _cidadeController.text = result['city'];
          _estadoController.text = result['state'];
          _cepController.text = result['cep'];
          //logformPaciente.toString());
        }
      },
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}

gravarPaciente(context, form) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => GravaPaciente(
        form: form,
      ),
    ),
  );
}




*/