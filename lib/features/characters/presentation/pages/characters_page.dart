import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/character_bloc.dart';
import '../bloc/character_event.dart';
import '../bloc/character_state.dart';
import '../widgets/character_list_item.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  _CharactersPageState createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final _scrollController = ScrollController();
  late CharacterBloc _characterBloc;

  @override
  void initState() {
    super.initState();
    _characterBloc = BlocProvider.of<CharacterBloc>(context);
    _characterBloc.add(const FetchCharacters(page: 1));
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom && !_characterBloc.isFetching) {
      _characterBloc.add(FetchCharacters(page: _characterBloc.page));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final threshold = 200.0;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return maxScroll - currentScroll <= threshold;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Персонажи'),
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state is CharacterLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CharacterLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.characters.length + (state.hasReachedEnd ? 0 : 1),
              itemBuilder: (context, index) {
                if (index >= state.characters.length) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  final character = state.characters[index];
                  return CharacterListItem(character: character);
                }
              },
            );
          } else if (state is CharacterError) {
            return Center(child: Text('Ошибка: ${state.message}'));
          } else {
            return const Center(child: Text('Нет данных'));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}