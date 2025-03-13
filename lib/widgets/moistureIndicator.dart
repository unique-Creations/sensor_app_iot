import 'package:flutter/material.dart';

class Moistureindicator extends StatelessWidget {
  final int value;
  final int minValue;
  final int maxValue;

  Moistureindicator({
    required this.value,
    required this.minValue,
    required this.maxValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      child: Stack(
        children: [
          Center(
            child: CircularProgressIndicator(
              value: value / 100,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                value < minValue
                    ? Colors.red
                    : value > maxValue
                    ? Colors.blue
                    : Colors.green,
              ),
              strokeWidth: 10,
            ),
          ),
          Center(
            child: Text(
              '$value%',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
