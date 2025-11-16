import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trip_misr/app/data/models/tripModel.dart';
import 'package:trip_misr/app/data/repositories/trips_repo.dart';

part 'all_trips_state.dart';

class AllTripsCubit extends Cubit<AllTripsState> {
  AllTripsCubit() : super(AllTripsInitial());

  final TripsRepo tripsRepo = TripsRepo();
  Future<void> getAllTrips() async {
    emit(AllTripsLoading());
    final response = await tripsRepo.fetchAllTrips();
    response.fold(
      (fail) => emit(AllTripsFailed()),
      (trips) => emit(AllTripsSuccess(trips)),
    );
  }

  List getAllTripsImages(List<TripModel> trips) {
    return trips
        .expand((trip) => (trip.images as List?)?.cast<String>() ?? [])
        .toList();
  }

 
}
