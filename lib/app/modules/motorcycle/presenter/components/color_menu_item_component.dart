import 'package:flutter/material.dart';

class ColorMenuItem extends StatelessWidget {
  final String colorName;
  final Color color;
  const ColorMenuItem({
    this.colorName = 'Cor',
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Row(
        children: [
          CircleAvatar(
            radius: 11,
            backgroundColor: color,
          ),
          SizedBox(width: 15),
          Text(colorName)
        ],
      ),
    );
  }
}
