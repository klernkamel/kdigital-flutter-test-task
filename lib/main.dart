import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'features/characters/presentation/pages/characters_page.dart';
import 'features/characters/presentation/bloc/character_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick and Morty Characters',
      home: BlocProvider(
        create: (_) => di.sl<CharacterBloc>(),
        child: const CharactersPage(),
      ),
    );
  }
}