import 'package:flutter_bloc/flutter_bloc.dart';
import 'character_event.dart';
import 'character_state.dart';
import '../../domain/usecases/get_characters.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetCharacters getCharacters;
  int page = 1;
  bool isFetching = false;

  CharacterBloc({required this.getCharacters}) : super(CharacterInitial()) {
    on<FetchCharacters>(_onFetchCharacters);
  }

  void _onFetchCharacters(
      FetchCharacters event, Emitter<CharacterState> emit) async {
    if (isFetching) return;
    isFetching = true;

    try {
      if (state is CharacterInitial) {
        emit(CharacterLoading());
        final characters = await getCharacters(event.page);
        emit(CharacterLoaded(characters: characters, hasReachedEnd: false));
      } else if (state is CharacterLoaded) {
        final currentState = state as CharacterLoaded;
        final characters = await getCharacters(event.page);
        if (characters.isEmpty) {
          emit(currentState.copyWith(hasReachedEnd: true));
        } else {
          emit(CharacterLoaded(
            characters: currentState.characters + characters,
            hasReachedEnd: false,
          ));
        }
      }
      page++;
    } catch (e) {
      emit(CharacterError(message: e.toString()));
    } finally {
      isFetching = false;
    }
  }
}