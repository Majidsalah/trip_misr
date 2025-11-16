import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:trip_misr/app/controllers/addTrip%20cubit/add_trip_cubit.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_fonts.dart';
import 'package:trip_misr/utils/snackBar.dart';
class AddImageWidget extends StatefulWidget {
  const AddImageWidget({super.key});

  @override
  State<AddImageWidget> createState() => _AddImageWidgetState();
}

class _AddImageWidgetState extends State<AddImageWidget> {
  final MultiImagePickerController _controller = MultiImagePickerController(
    maxImages: 5,
    picker: _customImagePicker,
  );
  static Future<List<ImageFile>> _customImagePicker(
      int maxImages, Object? extra) async {
    final picker = ImagePicker();
    List<ImageFile> result = [];
    final List<XFile?> picked = await picker.pickMultiImage();

    for (XFile? p in picked) {
      if (p != null) {
        final String filePath = p.path;

        result.add(ImageFile(
          filePath, // key (unique id — path is fine)
          name: p.name,
          extension: '', // remove leading dot if required
          path: filePath, // set the path explicitly
        ));
      } else {
        break;
      }
    }

    return result;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    await _controller.pickImages();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final hasImages = _controller.images.isNotEmpty;

    return Column(
      children: [
        if (!hasImages) // Show "Add Images" box only if no images yet
          GestureDetector(
            onTap: _pickImages,
            child: DottedBorder(
              strokeCap: StrokeCap.round,
              color: AppColors.kOrange,
              dashPattern: const [1, 3],
              radius: const Radius.circular(12),
              strokeWidth: 1.2,
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_photo_alternate_outlined,
                      color: AppColors.kOrange,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Add Images',
                      style: AppFonts.kBoldFont.copyWith(
                        color: AppColors.kOrange,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        else // Show image preview when images are picked
          Column(
            children: [
              Container(
                height: 200,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.kOrange.withOpacity(0.9)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: MultiImagePickerView(
                  controller: _controller,
                  padding: const EdgeInsets.all(4),
                  initialWidget: DefaultInitialWidget(
                    backgroundColor: AppColors.kOrange.withOpacity(0.5),
                    margin: EdgeInsets.zero,
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    BlocProvider.of<AddTripCubit>(context)
                        .setUploadedImages(_controller);
                  },
                  child: BlocConsumer<AddTripCubit, AddTripState>(
                    listener: (context, state) {
                      if (state is TripImagesUploaded) {
                        mySnackBar(context, sucess: "Uploaded Successfully");
                      } else if (state is TripImagesFailed) {
                        mySnackBar(context, failed: "Failed to  Uploaded !!");
                      }
                    },
                    builder: (context, state) {
                      if (state is TripImagesloading) {
                      return  const CircularProgressIndicator();
                      }

                      return const Text("Upload Images");
                    },
                  ))
            ],
          ),
      ],
    );
  }
}
