import 'package:flutter/material.dart';

class UserTileWg extends StatelessWidget {
  final String text;
  final void Function() onTap;

  const UserTileWg({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const Icon(Icons.person),
              Text(text),
            ],
          ),
        ));
  }
}
