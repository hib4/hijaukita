import 'package:flutter/material.dart';

import 'item/activity_item_widget.dart';

Widget historyActivity(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.only(top: 16),
    color: Colors.white,
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
        );
      },
    ),
  );
}
