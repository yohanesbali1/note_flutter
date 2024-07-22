import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nota/bloc/bloc.dart';
import 'package:nota/shared/shared.dart';
import 'package:nota/ui/page/pages.dart';
import 'package:provider/provider.dart';

void main() async {
  await initializeDateFormatting('id_ID', null)
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: null,
      initialData: null,
      child: MultiProvider(
          providers: [
            BlocProvider(create: (_) => PageBloc()),
          ],
          child: MaterialApp(
            theme: ThemeData(
              primaryColor: mainColor,
              fontFamily: monseratTextFont.fontFamily,
              textTheme: GoogleFonts.montserratTextTheme(),
            ),
            debugShowCheckedModeBanner: false,
            home: Wrapper(),
          )),
    );
  }
}
