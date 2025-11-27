part of 'all_trips_cubit.dart';

@immutable
sealed class AllTripsState {}

final class AllTripsInitial extends AllTripsState {}
final class AllTripsLoading extends AllTripsState {}
final class AllTripsSuccess extends AllTripsState {
  final List<TripModel> trips;

  AllTripsSuccess(this.trips);

}
final class AllTripsFailed extends AllTripsState {}
final class FilteredTripsFailed extends AllTripsState {}
final class TripImagesLoading extends AllTripsState {}
final class TripImagesFailed extends AllTripsState {}
final class TripImagesSuccess extends AllTripsState {
  final List<String>? images;

  TripImagesSuccess(this.images);
}
