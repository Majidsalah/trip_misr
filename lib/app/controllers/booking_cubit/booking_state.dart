part of 'booking_cubit.dart';

@immutable
sealed class BookingState {}

final class BookingInitial extends BookingState {}

final class BookingSuccess extends BookingState {}

final class BookingFailure extends BookingState {}

final class BookingLoading extends BookingState {}

final class BookedCustomersLoading extends BookingState {}

final class BookedCustomersSuccess extends BookingState {
  final List<BookingModel> bookedTrips;

  BookedCustomersSuccess(this.bookedTrips);
}

final class BookedCustomersFailure extends BookingState {}

final class TripsBookedByCustomerLoading extends BookingState {}

final class TripsBookedByCustomerSuccess extends BookingState {
  final List<BookingModel> bookedTrips;

  TripsBookedByCustomerSuccess(this.bookedTrips);
}

final class TripsBookedByCustomerFailure extends BookingState {}
