import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trip_misr/app/data/models/tripModel.dart';
import 'package:trip_misr/app/data/repositories/trips_repo.dart';

part 'posted_trips_state.dart';

class PostedTripsCubit extends Cubit<PostedTripsState> {
  PostedTripsCubit() : super(PostedTripsInitial());

  final TripsRepo postedTripRepo = TripsRepo();
  Future<void> getOrganizerPostedTrips() async {
    emit(PostedTripLoading());
    final response = await postedTripRepo.fetchPostedTrips();
    response.fold(
      (fail) => emit(PostedTripsFailed()),
      (trips) => emit(PostedTripsSuccess(trips)),
    );
  }

  Future<void> deletePostedTripById(String id) async {
    emit(DeletingTripsLoading());
    final response = await postedTripRepo.delete(id);
    response.fold(
      (fail) => emit(DeletingTripsFailed()),
      (success) => emit(DeletingTripsSucces()),
    );
  }
}
