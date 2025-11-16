import 'package:flutter/material.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_fonts.dart';
class PlaceCategoryList extends StatefulWidget {
  const PlaceCategoryList({
    super.key,
  });

  @override
  State<PlaceCategoryList> createState() => _PlaceCategoryListState();
}

class _PlaceCategoryListState extends State<PlaceCategoryList> {
  int _selected = 0;
  final List<String> name = [
    'Popular',
    'Lakes',
    'Pyramids',
    'Beach',
    'Nature',
  ];
  final List<IconData> icons = [
    Icons.local_fire_department,
    Icons.waves,
    Icons.landscape,
    Icons.beach_access,
    Icons.forest,
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 38,
      child: ListView.builder(
        itemCount: name.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (_, index) => GestureDetector(
          onTap: () {
            setState(() {
              _selected = index;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: _selected == index ? AppColors.kOrange : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    width: 1.2,
                    color: _selected == index
                        ? AppColors.kOrange
                        : AppColors.kLightBlue1)),
            child: Row(
              children: [
                Icon(icons[index],
                    color: _selected == index
                        ? Colors.white
                        : AppColors.kLightBlue1),
                Text(
                  name[index],
                  style: AppFonts.kRegularFont.copyWith(
                      color: _selected == index
                          ? Colors.white
                          : AppColors.kLightBlue1,
                      fontSize: 18.11),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
