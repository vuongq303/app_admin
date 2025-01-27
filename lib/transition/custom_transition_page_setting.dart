import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage<T> buildMyTransition<T>({
  required Widget child,
  required Color color,
  LocalKey? key,
}) {
  return CustomTransitionPage(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        _MyReveal(color: color, animation: animation, child: child),
    key: key,
    transitionDuration: const Duration(milliseconds: 500),
  );
}

class _MyReveal extends StatelessWidget {
  final Widget child;
  final Color color;
  final Animation<double> animation;

  final _slideTween = Tween(begin: const Offset(1, 0), end: Offset.zero);
  final _fadeTween = TweenSequence([
    TweenSequenceItem(tween: ConstantTween(0.0), weight: 1),
    TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 1),
  ]);

  _MyReveal(
      {required this.color, required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SlideTransition(
          position: _slideTween.animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: Container(
            color: color,
          ),
        ),
        FadeTransition(
          opacity: _fadeTween.animate(animation),
          child: child,
        ),
      ],
    );
  }
}
