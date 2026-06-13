import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.width,
    required this.height,
    required this.headText,
    required this.secondaryText,
    required this.contColor,
  });

  final double width;
  final double height;
  final String headText;
  final String secondaryText;
  final Color contColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10),
      width: width * .42,
      height: height * .1,
      decoration: BoxDecoration(
        color: contColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(headText),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: secondaryText,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                TextSpan(text: 'ج.م', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
