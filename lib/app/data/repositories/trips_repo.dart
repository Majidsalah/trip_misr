import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trip_misr/app/data/models/failureModel.dart';
import 'package:trip_misr/app/data/models/tripModel.dart';

class TripsRepo {
  final supabase = Supabase.instance.client;
  final user = Supabase.instance.client.auth.currentUser!.id;

  List<TripModel> parseTripsResponse(dynamic response) {
    if (response == null) return [];

    try {
      final List data = response as List;
      return data
          .map((e) => TripModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log("Error parsing trips: $e");
      return [];
    }
  }

  Future<Either<Failure, List<TripModel>>> fetchPostedTrips() async {
    try {
      final response =
          await supabase.from('trips').select().eq('organizer_id', user);
      final trips = parseTripsResponse(response);
      return right(trips);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, List<TripModel>>> fetchAllTrips() async {
    try {
      final response = await supabase.from('trips').select();
      final trips = parseTripsResponse(response);
      return right(trips);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, List<TripModel>>> fetchImageByTrip() async {
    try {
      final response = await supabase
          .from('trips')
          .select('images')
          .eq('organizer_id', user);
      final trips = parseTripsResponse(response);
      return right(trips);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, dynamic>> delete(String tripId) async {
    try {
      final response = await supabase.from('trips').delete().eq('id', tripId);
      log(response.toString());
      return right(response);
    } catch (e) {
      if (e is PostgrestException) {
        log('Supabase Error: ${e.message}');
        return left(Failure(e.message));
      } else {
        log('Unexpected Error: $e');
        return left(Failure(e.toString()));
      }
    }
  }
}
