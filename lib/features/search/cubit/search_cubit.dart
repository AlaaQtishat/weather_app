import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/search/cubit/search_state.dart';
import 'package:weather_app/features/search/services/search_service.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(InitialSearch());

  Future<void> getSearchResult(String name) async {
    emit(SearchLoading());
    try {
      final results = await SearchService.getSearchResults(name);
      emit(SearchLoaded(results: results));
    } catch (e) {
      emit(SearchError(errorMessage: e.toString()));
    }
  }

  void resetSearch() {
    emit(InitialSearch());
  }
}
