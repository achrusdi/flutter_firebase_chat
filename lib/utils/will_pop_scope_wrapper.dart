import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WillPopScopeWrapper extends StatefulWidget {
  final Widget child;
  final String exitWarning;

  const WillPopScopeWrapper(
      {super.key,
      required this.child,
      this.exitWarning = 'Are you sure you want to exit?'});

  @override
  State<WillPopScopeWrapper> createState() => _WillPopScopeWrapperState();
}

class _WillPopScopeWrapperState extends State<WillPopScopeWrapper> {
  DateTime? _lastBackPressTime;

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (_lastBackPressTime == null ||
        now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
      _lastBackPressTime = now;
      Fluttertoast.showToast(msg: widget.exitWarning);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: widget.child,
    );
  }
}
