import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/search/services/recents_service.dart';
import 'package:weather_app/features/search/cubit/recents_state.dart'; // تأكدي من المسار

class RecentsCubit extends Cubit<RecentsState> {
  final RecentsService _recentsService = RecentsService();

  RecentsCubit() : super(RecentsLoading());

  Future<void> loadRecents() async {
    try {
      emit(RecentsLoading());
      final recents = await _recentsService.getRecentSearches();
      emit(RecentsLoaded(recents: recents));
    } catch (e) {
      emit(RecentsError(errorMessage: "Failed to load recents"));
    }
  }

  Future<void> saveRecent(
    String name,
    String country,
    double lat,
    double lon,
  ) async {
    try {
      await _recentsService.saveRecentSearches(name, country, lat, lon);
      await loadRecents();
    } catch (e) {
      emit(RecentsError(errorMessage: "Failed to save location"));
    }
  }

  Future<void> removeRecent(String name, String country) async {
    try {
      await _recentsService.removeRecentSearch(name, country);
      await loadRecents();
    } catch (e) {
      emit(RecentsError(errorMessage: "Failed to remove location"));
    }
  }

  Future<void> clearAll() async {
    try {
      await _recentsService.clearAllRecents();
      await loadRecents();
    } catch (e) {
      emit(RecentsError(errorMessage: "Failed to clear recents"));
    }
  }
}
