import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Customsnackbar {
  static void showSnackBar(BuildContext context,String title,String body,Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.values[3]),
                  ),
                   Text(
                    body,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, letterSpacing: 2),
                  ),
                ],
              ),
            )),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
    );
  }
}