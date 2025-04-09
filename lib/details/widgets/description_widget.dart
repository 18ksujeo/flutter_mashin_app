import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  final String description;

  DescriptionWidget({required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.0),
          Text(
            description,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
