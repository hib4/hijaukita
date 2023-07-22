import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void navigatorPush(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    PageTransition(
      type: PageTransitionType.rightToLeft,
      duration: const Duration(milliseconds: 250),
      child: widget,
    ),
  );
}

void navigatorReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
    context,
    PageTransition(type: PageTransitionType.fade, child: widget),
  );
}

void navigatorPushAndRemove(BuildContext context, Widget widget) {
  Navigator.pushAndRemoveUntil(
    context,
    PageTransition(type: PageTransitionType.fade, child: widget),
    (route) => false,
  );
}

void navigatorPop(BuildContext context) {
  Navigator.pop(context);
}
