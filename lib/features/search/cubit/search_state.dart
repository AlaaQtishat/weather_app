import 'package:equatable/equatable.dart';
import 'package:weather_app/features/search/models/search_result_model.dart';

class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialSearch extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoading extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoaded extends SearchState {
  final List<SearchResultModel> results;
  SearchLoaded({required this.results});
  @override
  List<Object?> get props => [results];
}

class SearchError extends SearchState {
  final String errorMessage;
  SearchError({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
