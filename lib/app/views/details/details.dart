import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trip_misr/app/data/models/tripModel.dart';
import 'package:trip_misr/app/views/details/widgets/detailsImage.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_fonts.dart';
import 'package:trip_misr/utils/app_router.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.trip});
  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              FractionallySizedBox(
                widthFactor: 1.1,
                child: DetalisImage(
                  images: trip.images!,
                ),
              ),
              PlaceDetails(
                trip: trip,
              ),
              const SizedBox(height: 16),
              CustomButton(
                child: Text(
                  'Book A Trip',
                  style: AppFonts.kRegularFont
                      .copyWith(color: Colors.white, fontSize: 20.7),
                ),
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kBookingScreen,extra: trip);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ));
  }
}

class PlaceDetails extends StatefulWidget {
  const PlaceDetails({
    super.key,
    required this.trip,
  });
  final TripModel trip;

  @override
  State<PlaceDetails> createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {
  bool _isFavorite = false;
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.trip.title,
                  style: AppFonts.kRegularFont
                      .copyWith(color: AppColors.kBlue, fontSize: 36.22),
                ),
                Text(
                  '📍${widget.trip.governorate}',
                  style: AppFonts.kLightFont
                      .copyWith(color: AppColors.kLightBlue1, fontSize: 19.4),
                ),
                Text(
                  ' ${widget.trip.price} LE',
                  style: AppFonts.kBoldFont
                      .copyWith(color: AppColors.kLightOrange, fontSize: 19.4),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
              icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_outline,
                  size: 30,
                  color: _isFavorite ? AppColors.kOrange : Colors.grey),
              tooltip:
                  _isFavorite ? 'Remove from favorites' : 'Add to favorites',
            )
          ],
        ),
        const SizedBox(height: 16),
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          splashColor: AppColors.kLightOrange,
          child: Column(
            spacing: 8,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hotel: ${widget.trip.hotel}  ',
                    style: AppFonts.kBoldFont.copyWith(
                      color: AppColors.kLightBlue1,
                      fontSize: 18.7,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < (widget.trip.hotelRating ?? 0)
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                      );
                    }),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Meals:  ',
                    style: AppFonts.kBoldFont.copyWith(
                      color: AppColors.kLightBlue1,
                      fontSize: 18.7,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  _buildMealCheckbox('Breakfast', widget.trip.breakfast),
                  _buildMealCheckbox('Lunch', widget.trip.lunch),
                  _buildMealCheckbox('Dinner', widget.trip.dinner),
                ],
              ),
              cards("Vists: ", widget.trip.visits?.length ?? 0,
                  widget.trip.visits ?? []),
              cards("Activities: ", widget.trip.activities?.length ?? 0,
                  widget.trip.visits ?? []),
              Text(
                widget.trip.description ?? '',
                style: AppFonts.kLightFont.copyWith(
                  color: AppColors.kLightBlue1,
                  fontSize: 20.7,
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMealCheckbox(String label, bool? value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(color: AppColors.kOrange),
        ),
        Checkbox(
          value: value ?? false,
          activeColor: AppColors.kOrange,
          onChanged: (value) {}, // null = read-only
          checkColor: Colors.white,
        ),
      ],
    );
  }

  Row cards(String title, int lenght, List<String>? listOf) {
    return Row(
      children: [
        Text(
          title,
          style: AppFonts.kBoldFont.copyWith(
            color: AppColors.kLightBlue1,
            fontSize: 18.7,
            overflow: TextOverflow.fade,
          ),
        ),
        Row(
          children: List<Widget>.generate(lenght, (int index) {
            final visitName = listOf![index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  visitName,
                  style: AppFonts.kLightFont.copyWith(
                    color: AppColors.kLightBlue1,
                    fontSize: 18.7,
                    overflow: TextOverflow.fade,
                  ),
                  maxLines: _isExpanded ? 4 : null,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.child,
    this.onTap,
  });
  final Widget child;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 399.7,
        padding: const EdgeInsets.symmetric(vertical: 11),
        height: 69.85,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15.52)),
          color: AppColors.kOrange,
        ),
        child: Center(child: child),
      ),
    );
  }
}
