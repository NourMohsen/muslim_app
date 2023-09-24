import 'package:flutter/material.dart';
import 'package:muslim_task/constants.dart';
import 'package:muslim_task/core/utils/styles.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({
    Key? key,
    required this.slidingAnimation,
  }) : super(key: key);

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: slidingAnimation,
        builder: (context, _) {
          return SlideTransition(
            position: slidingAnimation,
            child:  Text(
              'Muslim App',
              textAlign: TextAlign.center,
              style: AppFontStyle.appBarTitle.copyWith(
                fontSize: 30,
                color: kBackgroundColor
              ),
            ),
          );
        });
  }
}
