import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:go_router/go_router.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_router.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

bool _showAnimatedText = false;

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 6), () {
      setState(() {
        _showAnimatedText = true;
      });
    });
    Future.delayed(const Duration(seconds: 8),
        () => _navigate()) ;
    super.initState();
    
  }

  Future<void> _navigate() async {
    final route = await getInitialRoute();
    if (!mounted) return;
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buitAnimatedText2(),
            if (_showAnimatedText)
              Image.asset(
                'assets/Layer 1.png',
                height: 300,
                width: 300,
              ),
            const SizedBox(height: 16),
            // if (_showAnimatedText) _buitAnimatedText(),
          ]),
    ));
  }
}

// _buitAnimatedText() {
//   return SizedBox(
//     width: 270,
//     child: RichText(
//       textAlign: TextAlign.start,
//       text: TextSpan(
//         text: 'TRIP MASR',
//         children: <TextSpan>[
//           TextSpan(
//             text: 'TRIP',
//             style: TextStyle(
//                 fontFamily: 'Bukhari', color: AppColors.kOrange, fontSize: 40),
//           ),
//           TextSpan(
//             text: 'MASR',
//             style: TextStyle(
//                 fontFamily: 'Bukhari', color: AppColors.kBlue, fontSize: 40),
//           ),
//         ],
//       ),
//     ),
//   );
// }

_buitAnimatedText2() {
  return SizedBox(
    width: 250.0,
    child: AnimatedTextKit(
      animatedTexts: [
        RotateAnimatedText('Be Ready',
            textAlign: TextAlign.center,
            textStyle: TextStyle(
                fontFamily: 'Bukhari', color: AppColors.kBlue, fontSize: 40),
            duration: const Duration(seconds: 2)),
        RotateAnimatedText('for fun',
            textAlign: TextAlign.center,
            textStyle: TextStyle(
                fontFamily: 'Bukhari', color: AppColors.kOrange, fontSize: 40),
            duration: const Duration(seconds: 2)),
      ],
      isRepeatingAnimation: false,
    ),
  );
}
