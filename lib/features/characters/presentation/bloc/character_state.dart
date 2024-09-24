import '../../domain/entities/character.dart';
import 'package:equatable/equatable.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object?> get props => [];
}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<Character> characters;
  final bool hasReachedEnd;

  const CharacterLoaded({required this.characters, required this.hasReachedEnd});

  CharacterLoaded copyWith({
    List<Character>? characters,
    bool? hasReachedEnd,
  }) {
    return CharacterLoaded(
      characters: characters ?? this.characters,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
    );
  }

  @override
  List<Object?> get props => [characters, hasReachedEnd];
}

class CharacterError extends CharacterState {
  final String message;

  const CharacterError({required this.message});

  @override
  List<Object?> get props => [message];
}