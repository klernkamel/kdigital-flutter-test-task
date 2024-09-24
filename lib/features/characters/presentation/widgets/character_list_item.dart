import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/character.dart';

class CharacterListItem extends StatelessWidget {
  final Character character;

  const CharacterListItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: character.image,
        placeholder: (context, url) => const CircleAvatar(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      title: Text(character.name),
      subtitle: Text('${character.species} - ${character.status}'),
      onTap: () {
        // Можно добавить переход на детальный экран персонажа
      },
    );
  }
}