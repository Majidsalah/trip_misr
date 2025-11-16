import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trip_misr/app/data/models/failureModel.dart';
import 'package:trip_misr/app/data/models/tripModel.dart';

class AddTripRepo {
  Future<Either<Failure, List<String>>> uploadImages(
      MultiImagePickerController controller) async {
    final supabase = Supabase.instance.client;
    final List<String> uploadedUrls = [];

    try {
      for (var image in controller.images) {
        final file = File(image.path!);
        final fileName =
            'trip_${DateTime.now().millisecondsSinceEpoch}_${image.name}';
        final filePath = 'images/$fileName';

        // Upload the file
        await supabase.storage.from('trips_images').upload(filePath, file);

        // Get public URL
        final publicUrl =
            supabase.storage.from('trips_images').getPublicUrl(filePath);

        uploadedUrls.add(publicUrl);
        log('✅ Uploaded: $publicUrl');
      }

      // Show success messag

      log('All uploaded URLs: $uploadedUrls');

      return right(uploadedUrls);
    } catch (e) {
      log('❌ Upload error: $e');
      return left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, TripModel>> createTrip(TripModel trip) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    try {
      final response = await Supabase.instance.client.from('trips').insert({
        'organizer_id': user.id, // هنا المنظم الحالي
        'title': trip.title,
        'description': trip.description,
        'governorate': trip.governorate,
        'gathering_place': trip.gatheringPlace,
        'start_date': trip.startDate.toIso8601String(),
        'end_date': trip.endDate?.toIso8601String(),
        'start_time': trip.startTime,
        'hotel': trip.hotel,
        'hotel_rating': trip.hotelRating,
        'breakfast': trip.breakfast,
        'lunch': trip.lunch,
        'dinner': trip.dinner,
        'visits': trip.visits,
        'activities': trip.activities,
        'price': trip.price,
        'is_active': trip.isActive,
        'images': trip.images,
      }).select();

      final addedTrip = TripModel.fromJson(response.first);

      return right(addedTrip);
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
