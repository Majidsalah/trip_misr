import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:trip_misr/app/controllers/Usercubit/user_cubit.dart';
import 'package:trip_misr/app/controllers/addTrip%20cubit/add_trip_cubit.dart';
import 'package:trip_misr/app/data/models/tripModel.dart';
import 'package:trip_misr/app/data/repositories/add_trip_repo.dart';
import 'package:trip_misr/app/views/organizer%20dashboard/addTrip/widgets/add_image.dart';
import 'package:trip_misr/component/custom_textField.dart';
import 'package:trip_misr/app/views/details/details.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_fonts.dart';
import 'package:trip_misr/utils/loading_indicator.dart';
import 'package:trip_misr/utils/snackBar.dart';

class AddTripScreen extends StatefulWidget {
  const AddTripScreen({super.key});

  @override
  State<AddTripScreen> createState() => _AddTripScreenState();
}

class _AddTripScreenState extends State<AddTripScreen> {
  final MultiImagePickerController imageController = MultiImagePickerController(
    maxImages: 5,
    picker: AddImageWidget.customImagePicker, // نفس الفانكشن
  );
  AddTripRepo addtrip = AddTripRepo();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  double _rating = 0;
  bool? _meal1 = false;
  bool? _meal2 = false;
  bool? _meal3 = false;
  final List<String>? _vistsList = [];
  final List<String>? _activityList = [];
  final TextEditingController _vists = TextEditingController();
  final TextEditingController _activity = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController? description = TextEditingController();
  final TextEditingController? governorate = TextEditingController();
  final TextEditingController? gatheringPlace = TextEditingController();
  final TextEditingController? hotel = TextEditingController();
  final TextEditingController? price = TextEditingController();

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    setState(() => _selectedDate = pickedDate);
  }

  Future<void> _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() => _selectedTime = pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Post New Trip',
              style: AppFonts.kBoldFont
                  .copyWith(fontSize: 24, color: Colors.white),
            ),
            shadowColor: AppColors.kLightBlue2,
            elevation: 6,
            backgroundColor: AppColors.kOrange,
          ),
          body: Form(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  AddImageWidget(controller: imageController),
                  const SizedBox(height: 24),
                  CustomTextField(
                    lab: "Governorate",
                    controller: governorate,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    lab: "Gathering Point",
                    controller: gatheringPlace,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'This field is required';
                      }
                      return '';
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    lab: "Trip Destination",
                    controller: title,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'This field is required';
                      }
                      return '';
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    lab: "Price",
                    keyboardType: TextInputType.number,
                    controller: price,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'This field is required';
                      }
                      return '';
                    },
                  ),
                  const SizedBox(height: 16),
                  Divider(color: AppColors.kOrange),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Time :',
                        style: TextStyle(color: AppColors.kOrange),
                      ),
                      SizedBox(
                        width: 100,
                        child: TextButton(
                          onPressed: () => _pickTime(),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.kLightBlue1,
                          ),
                          child: _selectedTime == null
                              ? const Icon(
                                  Icons.schedule,
                                  color: Colors.white,
                                )
                              : Text(
                                  _selectedTime!.format(context),
                                  style: AppFonts.kRegularFont.copyWith(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                      Text(
                        'Date :',
                        style: TextStyle(color: AppColors.kOrange),
                      ),
                      SizedBox(
                        width: 120,
                        child: TextButton(
                          onPressed: () => _pickDate(),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.kLightBlue1,
                          ),
                          child: _selectedDate == null
                              ? const Icon(
                                  Icons.calendar_month,
                                  color: Colors.white,
                                )
                              : Text(
                                  DateFormat('yyyy-MM-dd')
                                      .format(_selectedDate!),
                                  style: AppFonts.kRegularFont.copyWith(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(color: AppColors.kOrange),
                  const SizedBox(height: 16),
                  CustomTextField(
                    lab: "Hotel Name",
                    controller: hotel,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'This field is required';
                      }
                      return '';
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < _rating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                        ),
                        onPressed: () {
                          setState(() {
                            _rating = index + 1.0;
                          });
                        },
                      );
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'BreakFast',
                        style: TextStyle(color: AppColors.kOrange),
                      ),
                      Checkbox(
                          value: _meal1,
                          activeColor: AppColors.kOrange,
                          checkColor: Colors.white,
                          onChanged: (val) {
                            setState(() {
                              _meal1 = val;
                            });
                          }),
                      Text(
                        'Lunch',
                        style: TextStyle(color: AppColors.kOrange),
                      ),
                      Checkbox(
                          value: _meal2,
                          activeColor: AppColors.kOrange,
                          checkColor: Colors.white,
                          onChanged: (val) {
                            setState(() {
                              _meal2 = val;
                            });
                          }),
                      Text(
                        'Dinner',
                        style: TextStyle(color: AppColors.kOrange),
                      ),
                      Checkbox(
                          value: _meal3,
                          activeColor: AppColors.kOrange,
                          checkColor: Colors.white,
                          onChanged: (val) {
                            setState(() {
                              _meal3 = val;
                            });
                          }),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(color: AppColors.kOrange),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add Visits',
                        style: TextStyle(color: AppColors.kOrange),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Tourist Visits'),
                                  content: CustomTextField(
                                    lab: 'Vists',
                                    controller: _vists,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        _vists?.text == null
                                            ? null
                                            : setState(() {
                                                _vistsList?.add(_vists!.text);
                                                _vists?.clear();
                                              });
                                      },
                                      child: const Text('Add'),
                                    ),
                                  ],
                                );
                              });
                        },
                        color: AppColors.kOrange,
                      ),
                    ],
                  ),
                  Wrap(
                    children: List.generate(_vistsList!.length, (index) {
                      return Chip(
                        label: Text(_vistsList![index]),
                        deleteIcon: const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                        onDeleted: () {
                          setState(() {
                            _vistsList!.removeAt(index);
                          });
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add Activity',
                        style: TextStyle(color: AppColors.kOrange),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Tourist Activities'),
                                  content: CustomTextField(
                                    lab: 'Activities',
                                    controller: _activity,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        _activity?.text == null
                                            ? null
                                            : setState(() {
                                                _activityList
                                                    ?.add(_activity!.text);
                                                _activity?.clear();
                                              });
                                      },
                                      child: const Text('Add'),
                                    ),
                                  ],
                                );
                              });
                        },
                        color: AppColors.kOrange,
                      ),
                    ],
                  ),
                  Wrap(
                    children: List.generate(_activityList!.length, (index) {
                      return Chip(
                        label: Text(_activityList![index]),
                        deleteIcon: const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                        onDeleted: () {
                          setState(() {
                            _activityList!.removeAt(index);
                          });
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    lab: 'Notes',
                    height: 5,
                    controller: description,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'This field is required';
                      }
                      return '';
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    onTap: () async {
                      TripModel trip = TripModel(
                        title: title.text,
                        description: description?.text,
                        governorate: governorate?.text,
                        gatheringPlace: gatheringPlace?.text,
                        startDate: _selectedDate ?? DateTime.now(),
                        startTime: _selectedTime?.format(context),
                        hotel: hotel?.text,
                        hotelRating: _rating.toInt(),
                        breakfast: _meal1 ?? false,
                        lunch: _meal2 ?? false,
                        dinner: _meal3 ?? false,
                        visits: _vistsList,
                        activities: _activityList,
                        price: double.tryParse(price!.text) ?? 0.0,
                        isActive: true,
                      );
                      await BlocProvider.of<AddTripCubit>(context)
                          .addNewTrip(trip, imageController);
                    },
                    child: BlocConsumer<AddTripCubit, AddTripState>(
                      listener: (context, state) {
                        if (state is AddTripLoading ||
                            state is TripImagesloading) {
                          showProgressIndicator(context);
                        } else {
                          Navigator.pop(context);
                          if (state is AddTripSuccess) {
                          
                            mySnackBar(context,
                                sucess: "Trip added successfully");
                            context.read<HomeCubit>().changeTab(0);
                          } else if (state is AddTripFailed) {
                            mySnackBar(context,
                                failed: "Trip failed to added !!");
                          }
                        }
                      },
                      builder: (context, state) {
                        return Text(
                          'Post',
                          style: AppFonts.kRegularFont.copyWith(
                            color: Colors.white,
                            fontSize: 20.7,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
