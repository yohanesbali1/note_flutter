import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nota/bloc/bloc.dart';
import 'package:nota/ui/page/pages.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
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
            debugShowCheckedModeBanner: false,
            home: Wrapper(),
          )),
    );
  }
}
