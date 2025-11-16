part of 'add_trip_cubit.dart';

@immutable
sealed class AddTripState {}

final class AddTripInitial extends AddTripState {}

final class AddTripLoading extends AddTripState {}

final class AddTripSuccess extends AddTripState {}

final class AddTripFailed extends AddTripState {
  AddTripFailed(String message);
}

final class TripImagesUploaded extends AddTripState {
  TripImagesUploaded(List<String> urls);
}

final class TripImagesloading extends AddTripState {
}

final class TripImagesFailed extends AddTripState {
  TripImagesFailed(String message);
}
