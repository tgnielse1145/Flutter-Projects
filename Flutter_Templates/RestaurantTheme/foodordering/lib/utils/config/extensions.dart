import 'package:flutter/material.dart';
import 'package:foodordering/animations/bounce.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:flutter/widgets.dart';
import 'package:foodordering/animations/fade_in.dart';

extension AnimatedWidgetExtension on Widget {
  fadeIn(double delay) {
    return FadeIn(delay, this);
  }

  bounce() {
    return Bounce(this, this);
  }

  fadeInList(int index, bool isVerical) {
    double offset = 50.0;
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 900),
      child: SlideAnimation(
        horizontalOffset: isVerical ? 0.0 : offset,
        verticalOffset: !isVerical ? 0.0 : offset,
        child: FadeInAnimation(
          child: this,
        ),
      ),
    );
  }
}

// extension OtherWidgetExtension on Widget {
//   deleteOverlay({VoidCallback onTap, Color color}) {
//     return DeleteOverlay(
//       child: this,
//       onTap: onTap,
//       color: color ?? Colors.grey.withOpacity(0.1),
//     );
//   }
// }
