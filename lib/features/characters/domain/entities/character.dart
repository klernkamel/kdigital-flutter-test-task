import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final Origin origin;
  final Location location;
  final String image;
  final List<String> episode;
  final String url;
  final String created;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  @override
  List<Object?> get props => [id, name];
}

class Origin extends Equatable {
  final String name;
  final String url;

  const Origin({required this.name, required this.url});

  @override
  List<Object?> get props => [name, url];
}

class Location extends Equatable {
  final String name;
  final String url;

  const Location({required this.name, required this.url});

  @override
  List<Object?> get props => [name, url];
}