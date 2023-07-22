import 'package:flutter/material.dart';

Widget listMenu(BuildContext context, String title, Icon icon, Color color,{required VoidCallback onTap}) {
  final textTheme = Theme.of(context).textTheme;
  return InkWell(
    onTap: onTap,
    splashColor: Colors.white,
    borderRadius: BorderRadius.circular(12.5),
    child: Row(
      children: [
        Container(
            height: 45,
            width: 45,
            decoration: const BoxDecoration(
              color: Color(0XFFF9F9F9),
              borderRadius: BorderRadius.all(
                Radius.circular(12.5),
              ),
            ),
            child: icon
        ),
        const SizedBox(width: 15),
        Text(
          title,
          style: textTheme.bodyText1!.copyWith(
              color: color
          ),
        ),
        const Spacer(),
        const Icon(Icons.navigate_next_sharp)
      ],
    ),
  );
}