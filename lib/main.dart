import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nova_agenda/agenda6.dart';

void main() async {
  //await findSystemLocale();
  //initializeDateFormatting().then((_) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // kAccent.withOpacity(0.3)
      ),
    );
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vera1',
      themeMode: ThemeMode.light,
      initialRoute: '/',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), //
        Locale('pt', 'BR'), //
      ],
      locale: Locale('pt', 'BR'),
      home: CustomTableCalendar(),
    );
  }
}
