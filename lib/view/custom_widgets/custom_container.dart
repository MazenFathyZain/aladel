import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomContainer extends StatelessWidget {
  final String? title;
  final String? leading;

  CustomContainer({this.title, this.leading});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: primaryColor,
          style: BorderStyle.solid,
          width: 1.0,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ListTile(
        leading: Text(leading!),
        title: Text(
          title!,
          maxLines: 1,
        ),
      ),
    );
  }
}
