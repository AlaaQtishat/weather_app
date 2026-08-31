import 'package:equatable/equatable.dart';

class PreferencesState extends Equatable {
  final String tempUnit;
  final String timeFormat;
  final bool isDarkMode;

  const PreferencesState({
    required this.tempUnit,
    required this.timeFormat,
    required this.isDarkMode,
  });

  PreferencesState copyWith({
    String? tempUnit,
    String? timeFormat,
    bool? isDarkMode,
  }) {
    return PreferencesState(
      tempUnit: tempUnit ?? this.tempUnit,
      timeFormat: timeFormat ?? this.timeFormat,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  @override
  List<Object> get props => [tempUnit, timeFormat, isDarkMode];
}
