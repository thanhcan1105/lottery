import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeIn extends StatelessWidget {
  final double? delay;
  final Widget? child;

  FadeIn({this.delay, this.child});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final tween = MultiTrackTween([
      // ignore: deprecated_member_use
      Track("opacity")
          .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      // ignore: deprecated_member_use
      Track("translateX").add(
          Duration(milliseconds: 250), Tween(begin: 230.0, end: 0.0),
          curve: Curves.easeOut)
    ]);

    // ignore: deprecated_member_use
    return ControlledAnimation(
      delay: Duration(milliseconds: (200 * delay!).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, Map<String, dynamic> animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: Offset(animation["translateX"], 0), child: child),
      ),
    );
  }
}

class ScaleIn extends StatelessWidget {
  final double? delay;
  final Widget? child;

  ScaleIn({this.delay, this.child});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final tween = MultiTrackTween([
      // ignore: deprecated_member_use
      Track("opacity")
          .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      // ignore: deprecated_member_use
      Track("translateY").add(
          Duration(milliseconds: 150), Tween(begin: 1.0, end: 0.0),
          curve: Curves.decelerate)
    ]);

    // ignore: deprecated_member_use
    return ControlledAnimation(
      delay: Duration(milliseconds: (200 * delay!).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child,  Map<String, dynamic> animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: Offset(animation["translateY"], 0), child: child),
      ),
    );
  }
}
// enum _AniProps { opacity, translateX }
// class FadeIn extends StatelessWidget {
//   final double delay;
//   final Widget child;

//   FadeIn(this.delay, this.child);

//   @override
//   Widget build(BuildContext context) {
//     final tween = MultiTween<_AniProps>()..add(_AniProps.opacity, 0.0.tweenTo(1.0))..add(_AniProps.translateX, 130.0.tweenTo(0.0));

//     return PlayAnimation<MultiTweenValues<_AniProps>>(
//       delay: (300 * delay).round().milliseconds,
//       duration: 500.milliseconds,
//       tween: tween,
//       child: child,
//       builder: (context, child, value) => Opacity(
//         opacity: value.get(_AniProps.opacity),
//         child: Transform.translate(
//           offset: Offset(value.get(_AniProps.translateX), 0),
//           child: child,
//         ),
//       ),
//     );
//   }
// }
