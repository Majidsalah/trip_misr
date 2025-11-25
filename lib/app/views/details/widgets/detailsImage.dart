import 'package:flutter/material.dart';
import 'package:trip_misr/utils/app_colors.dart';

class DetalisImage extends StatefulWidget {
  const DetalisImage({super.key, required this.images});
  final List<String> images;
  @override
  DetalisImageState createState() => DetalisImageState();
}

class DetalisImageState extends State<DetalisImage> {
  // final List<Map<String, dynamic>> thumbnails = [
  //   {'image': 'assets/28612.jpg', 'isVideo': true},
  //   {'image': 'assets/image_processing20240319-2-1ayekd.jpg', 'isVideo': false},
  //   {'image': 'assets/Taba.jpg', 'isVideo': false},
  //   {'image': 'assets/images_15.jpeg.jpg', 'isVideo': false},
  //   {'image': 'assets/28612.jpg', 'isVideo': true},
  //   {'image': 'assets/image_processing20240319-2-1ayekd.jpg', 'isVideo': false},
  //   {'image': 'assets/Taba.jpg', 'isVideo': false},
  //   {'image': 'assets/images_15.jpeg.jpg', 'isVideo': false},
  // ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasImages = widget.images.isNotEmpty;
    final thumbnails = widget.images;
    return Container(
      height: 400,
      width: 400,
      padding: const EdgeInsets.only(
        bottom: 5,
      ),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 3),
                blurRadius: 4,
                color: AppColors.kLightBlue1),
          ],
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: hasImages
                  ? Image.network(
                      thumbnails[selectedIndex],
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                    'assets/no_trips.png',
                    fit: BoxFit.fitHeight,
                                      
                  ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              height: 30,
              width: 30,
              margin: const EdgeInsets.only(right: 6, top: 6),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.kDisable.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: const Icon(Icons.close_fullscreen_outlined),
                color: Colors.white,
                iconSize: 24,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 350,
              width: 70,
              margin: const EdgeInsets.only(left: 12),
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: thumbnails.length,
                  itemBuilder: (_, index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: _buildThumbnail(thumbnails, index))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnail(List<String> thumbnail, int index) {
    return Container(
      // margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: selectedIndex == index ? AppColors.kOrange : Colors.white38,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(7),
            bottomLeft: Radius.circular(7),
            topRight: Radius.circular(7),
            bottomRight: Radius.circular(7),
          ),
          border: Border.all(
              color: selectedIndex == index ? Colors.white : Colors.transparent,
              width: selectedIndex == index ? 3 : 0)),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              thumbnail[index],
              fit: BoxFit.fill,
              height: selectedIndex == index ? 40 : 30,
              width: selectedIndex == index ? 60 : 30,
            ),
          ),
        ],
      ),
    );
  }
}
