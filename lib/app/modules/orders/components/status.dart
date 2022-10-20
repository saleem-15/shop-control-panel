import 'package:flutter/material.dart';

class Status extends StatelessWidget {
  const Status({
    Key? key,
    required this.status,
  }) : super(key: key);
  final String status;
  @override
  Widget build(BuildContext context) {
    late Color textColor;
    late Color backgroundColor;

    switch (status) {
      case 'Complete':
        textColor = const Color(0xff05B651);
        backgroundColor = const Color(0xffEEF7F2);
        break;
      case 'Processing':
        textColor = Colors.blue.shade300;
        backgroundColor = Colors.blue.shade50;
        break;
      case 'Pending':
        textColor = const Color(0xffFE9A28);
        backgroundColor = const Color(0xffFAF5EF);
        break;
      case 'Canceled':
        textColor = const Color(0xffF46C6C);
        backgroundColor = const Color(0xffFAF0F0);
        break;

      default:
        throw ('status = $status ==> order status must either be (Complete,Processing,Pending,Canceled)');
    }

    return Chip(
      backgroundColor: backgroundColor,
      padding: const EdgeInsets.all(8.0),
      side: BorderSide.none,
      label: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
