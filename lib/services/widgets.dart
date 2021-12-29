import 'package:flutter/material.dart';
import 'package:nova_agenda/paginas/setup.dart';

appBarra(context, String texto) {
  return AppBar(
    title: Text(texto),
    centerTitle: true,
    elevation: 3,
//    backgroundColor: Colors.blue.shade900,
    actions: [
      IconButton(
        onPressed: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Setup(),
            ),
          ),
        },
        icon: const Icon(Icons.settings),
      ),
      const SizedBox(
        width: 10,
      ),
    ],
  );
}

txtro(String texto, double tamanho, int peso) {
  FontWeight fWeight = FontWeight.w100;

  switch (peso) {
    case 1:
      fWeight = FontWeight.w100;
      break;
    case 2:
      fWeight = FontWeight.w200;
      break;
    case 3:
      fWeight = FontWeight.w300;
      break;
    case 4:
      fWeight = FontWeight.w400;
      break;
    case 5:
      fWeight = FontWeight.w500;
      break;
    case 6:
      fWeight = FontWeight.w600;
      break;
    case 7:
      fWeight = FontWeight.w700;
      break;
    case 8:
      fWeight = FontWeight.w800;
      break;
    case 9:
      fWeight = FontWeight.w900;
      break;
    default:
      fWeight = FontWeight.w400;
  }
  return Text(
    texto,
    style: TextStyle(
      fontFamily: 'RobotoSlab',
      fontSize: tamanho,
      fontWeight: fWeight,
    ),
  );
}

txtnu(String texto, double tamanho, int peso) {
  FontWeight fWeight = FontWeight.w100;

  switch (peso) {
    case 1:
      fWeight = FontWeight.w100;
      break;
    case 2:
      fWeight = FontWeight.w200;
      break;
    case 3:
      fWeight = FontWeight.w300;
      break;
    case 4:
      fWeight = FontWeight.w400;
      break;
    case 5:
      fWeight = FontWeight.w500;
      break;
    case 6:
      fWeight = FontWeight.w600;
      break;
    case 7:
      fWeight = FontWeight.w700;
      break;
    case 8:
      fWeight = FontWeight.w800;
      break;
    case 9:
      fWeight = FontWeight.w900;
      break;
    default:
      fWeight = FontWeight.w400;
  }
  return Text(
    texto,
    style: TextStyle(
      fontFamily: 'Nunito',
      fontSize: tamanho,
      fontWeight: fWeight,
    ),
  );
}
