import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trip_misr/component/custom_textField.dart';
import 'package:trip_misr/utils/app_colors.dart';

class CustomerBooking extends StatefulWidget {
  const CustomerBooking({super.key});

  @override
  State<CustomerBooking> createState() => _CustomerBookingState();
}

class _CustomerBookingState extends State<CustomerBooking> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> egyptGovernorates = [
      "Cairo (القاهرة)",
      "Giza (الجيزة)",
      "Alexandria (الإسكندرية)",
      "Beheira (البحيرة)",
      "Matrouh (مطروح)",
      "Kafr El Sheikh (كفر الشيخ)",
      "Monufia (المنوفية)",
      "Gharbia (الغربية)",
      "Dakahlia (الدقهلية)",
      "Sharqia (الشرقية)",
      "Damietta (دمياط)",
      "Port Said (بورسعيد)",
      "Ismailia (الإسماعيلية)",
      "Suez (السويس)",
      "North Sinai (شمال سيناء)",
      "South Sinai (جنوب سيناء)",
      "Fayoum (الفيوم)",
      "Beni Suef (بني سويف)",
      "Minya (المنيا)",
      "Assiut (أسيوط)",
      "Sohag (سوهاج)",
      "Qena (قنا)",
      "Luxor (الأقصر)",
      "Aswan (أسوان)",
      "New Valley (الوادي الجديد)",
      "Red Sea (البحر الأحمر)",
    ];
    String? val;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: 400,
            child: Stepper(
              type: StepperType.vertical,
              currentStep: _currentStep,
              connectorColor: WidgetStateProperty.all(AppColors.kOrange),
              connectorThickness: 2,
              onStepContinue: () {
                if (_currentStep != 2) {
                  setState(() {
                    _currentStep += 1;
                  });
                }
              },
              onStepCancel: () {
                if (_currentStep != 0) {
                  setState(() {
                    _currentStep -= 1;
                  });
                }
              },
              steps: [
                Step(
                  title: const Text('Governorate'),
                  isActive: _currentStep == 0,
                  state:
                      _currentStep > 0 ? StepState.complete : StepState.indexed,
                  stepStyle: StepStyle(
                      color: AppColors.kOrange,
                      connectorColor: AppColors.kOrange,
                      connectorThickness: 3),
                  content: DropdownButtonFormField(
                    padding: const EdgeInsets.only(bottom: 16),
                    hint: const Text('Choose Governorate'),
                    items: egyptGovernorates
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                    value: val,
                    onChanged: (value) {
                      setState(() {
                        val = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Step(
                  title: const Text('Gathering Point'),
                  state:
                      _currentStep > 1 ? StepState.complete : StepState.indexed,
                  stepStyle: StepStyle(
                    color: AppColors.kOrange,
                  ),
                  isActive: false,
                  content: DropdownButtonFormField(
                    padding: const EdgeInsets.only(bottom: 16),
                    items: egyptGovernorates
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                    value: val,
                    onChanged: (value) {
                      setState(() {
                        val = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Step(
                    title: const Text('Booking'),
                    state: _currentStep > 2
                        ? StepState.complete
                        : StepState.indexed,
                    stepStyle: StepStyle(
                        color: _currentStep == 2
                            ? AppColors.kOrange
                            : AppColors.kDisable,
                        indexStyle: TextStyle(
                            color: _currentStep == 2
                                ? Colors.white
                                : AppColors.kBlue),
                        connectorColor: AppColors.kOrange),
                    isActive: _currentStep == 2,
                    content: SizedBox(
                      height: 350,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextField(
                            hint: ' Enter your name',
                            icon: const Icon(
                              Icons.person,
                            ),
                            lab: 'Name',
                            controller: TextEditingController(),
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            hint: ' Enter your Phone',
                            icon: const Icon(
                              Icons.phone,
                            ),
                            lab: 'Phone',
                            controller: TextEditingController(),
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            hint: ' Number of children',
                            icon: const Icon(
                              Icons.child_care,
                            ),
                            lab: 'Children',
                            controller: TextEditingController(),
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            hint: ' Number of adult',
                            icon: const Icon(
                              Icons.group,
                            ),
                            lab: 'Person',
                            controller: TextEditingController(),
                          ),
                        ],
                      ),
                    )),
              ],
              controlsBuilder:
                  (BuildContext context, ControlsDetails controls) {
                return Row(
                  children: [
                    ElevatedButton(
                      onPressed: controls.onStepContinue,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.kOrange),
                      child: const Text(
                        'Continue',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    TextButton(
                      onPressed: controls.onStepCancel,
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: AppColors.kOrange),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
