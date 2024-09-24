import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../domain/entities/character.dart';
import '../../domain/repositories/character_repository.dart';
import '../models/character_model.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final http.Client client;

  CharacterRepositoryImpl({required this.client});

  @override
  Future<List<Character>> getCharacters(int page) async {
    final response = await client.get(
      Uri.parse('https://rickandmortyapi.com/api/character/?page=$page'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      return results
          .map((json) => CharacterModel.fromJson(json).toEntity())
          .toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }
}