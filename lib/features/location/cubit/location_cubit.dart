import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/location/services/location_service.dart';
import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  Future<void> fetchUserLocation() async {
    emit(LocationLoading());
    try {
      final position = await LocationService.getCurrentPosition();
      final cityName = await LocationService.getCityName(
        position.latitude,
        position.longitude,
      );

      emit(
        LocationLoaded(
          cityName: cityName,
          lat: position.latitude,
          lon: position.longitude,
        ),
      );
    } catch (e) {
      emit(LocationError(e.toString().replaceAll("Exception: ", "")));
    }
  }
}
