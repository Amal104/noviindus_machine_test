import 'package:flutter/material.dart';

import '../../Utils/AppColor.dart';

class RegsterDataTab extends StatelessWidget {
  const RegsterDataTab({
    super.key,
    required this.hint,
    required this.controller, required this.type,
  });

  final String hint;
  final TextEditingController controller;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: AppColor.lightGrey, borderRadius: BorderRadius.circular(8)),
        child: TextField(
          controller: controller,
          keyboardType: type,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 15,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
