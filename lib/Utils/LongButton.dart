import 'package:flutter/material.dart';

import 'AppColor.dart';

class LongButton extends StatelessWidget {
  const LongButton({
    super.key,
    this.function,
    required this.title,
  });

  final void Function()? function;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColor.green,
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColor.white,
            ),
          ),
        ),
      ),
    );
  }
}
