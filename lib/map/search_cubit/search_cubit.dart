import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:outshade/model/address.dart';
import 'package:outshade/services/search_service.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  SearchService service = SearchService();

  void search(String query) async {
    emit(Searching());

    List<Suggestion> data = await service.fetchSuggestions(query);

    emit(SearchedLocation(suggestions: data));
  }
}
