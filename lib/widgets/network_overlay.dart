import 'package:flutter/material.dart';

class NetworkOverlay extends StatelessWidget {
  final Widget child;
  final bool showOverlay;

  const NetworkOverlay({
    Key? key,
    required this.child,
    required this.showOverlay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          child,
          if (showOverlay) const NetworkErrorSnackBar(),
        ],
      ),
    );
  }
}

class NetworkErrorSnackBar extends StatelessWidget {
  const NetworkErrorSnackBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 90,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.redAccent.shade200,
            ),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Network issue detected, reconnecting...',
            ),
          ),
        ],
      ),
    );
  }
}
