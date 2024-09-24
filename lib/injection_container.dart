import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'features/characters/data/repositories/character_repository_impl.dart';
import 'features/characters/domain/repositories/character_repository.dart';
import 'features/characters/domain/usecases/get_characters.dart';
import 'features/characters/presentation/bloc/character_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(() => CharacterBloc(getCharacters: sl()));

  // UseCases
  sl.registerLazySingleton(() => GetCharacters(sl()));

  // Repositories
  sl.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(client: sl()),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
}