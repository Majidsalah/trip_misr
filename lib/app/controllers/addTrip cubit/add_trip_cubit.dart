import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:trip_misr/app/controllers/all_trips_cubit/all_trips_cubit.dart';
import 'package:trip_misr/app/data/models/tripModel.dart';
import 'package:trip_misr/app/data/repositories/add_trip_repo.dart';

part 'add_trip_state.dart';

class AddTripCubit extends Cubit<AddTripState> {
  AddTripCubit() : super(AddTripInitial());
  final AddTripRepo addTripRepo = AddTripRepo();

  List<String> uploadedImages = [];

   Future<void> setUploadedImages(MultiImagePickerController controller) async {
    emit(TripImagesloading());

    final response = await addTripRepo.uploadImages(controller);
    response.fold(
      (failure) => emit(TripImagesFailed(failure.message)),
       (success) {
        uploadedImages = success; // ✅ حفظ الصور هنا
        emit(TripImagesUploaded(uploadedImages));
      },
    );
  }

  Future<void> addNewTrip(TripModel trip,MultiImagePickerController controller) async {
   await setUploadedImages(controller);
    emit(AddTripLoading());
    final updatedTrip = trip.copyWith(images: uploadedImages);

    final response = await addTripRepo.createTrip(updatedTrip);
    
    response.fold(
      (failure) => emit(AddTripFailed(failure.message)),
      (sucess) => emit(AddTripSuccess()),
    );
  }
}
