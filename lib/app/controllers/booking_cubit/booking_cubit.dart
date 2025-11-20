import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trip_misr/app/data/models/bookingModel.dart';
import 'package:trip_misr/app/data/repositories/trips_repo.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());

  Future<void> createBooking(BookingModel booking) async {
    final TripsRepo tripsRepo = TripsRepo();

    emit(BookingLoading());

    final response = await tripsRepo.createBooking(booking);

    response.fold(
      (failure) => emit(BookingFailure()),
      (sucess) => emit(BookingSuccess()),
    );
  }

  Future<void> getBookedCustomersByTrip(String tripId) async {
    final TripsRepo tripsRepo = TripsRepo();

    emit(BookedCustomersLoading());

    final response = await tripsRepo.getBookedCustomersByTrip(tripId);

    response.fold(
      (failure) => emit(BookedCustomersFailure()),
      (booked) => emit(BookedCustomersSuccess(booked)),
    );
  }

  Future<void> getBookedTripByCustomer() async {
    final TripsRepo tripsRepo = TripsRepo();

    emit(TripsBookedByCustomerLoading());

    final response = await tripsRepo.getBookedTripByCustomer();

    response.fold(
      (failure) => emit(TripsBookedByCustomerFailure()),
      (booked) => emit(TripsBookedByCustomerSuccess(booked)),
    );
  }
}
