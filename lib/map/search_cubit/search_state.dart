part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchedLocation extends SearchState {
  final List<Suggestion> suggestions;

  SearchedLocation({this.suggestions});
  @override
  List<Object> get props => [];
}

class Searching extends SearchState {}
