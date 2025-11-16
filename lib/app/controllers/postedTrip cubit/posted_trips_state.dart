part of 'posted_trips_cubit.dart';

@immutable
sealed class PostedTripsState {}

final class PostedTripsInitial extends PostedTripsState {}
final class PostedTripLoading extends PostedTripsState {}
final class PostedTripsSuccess extends PostedTripsState {
  final List<TripModel> trips;

  PostedTripsSuccess(this.trips);
}
final class PostedTripsFailed extends PostedTripsState {}
final class DeletingTripsLoading extends PostedTripsState {}
final class DeletingTripsSucces extends PostedTripsState {}
final class DeletingTripsFailed extends PostedTripsState {}
