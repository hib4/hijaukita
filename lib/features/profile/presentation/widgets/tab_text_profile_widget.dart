import 'package:flutter/material.dart';

Widget tabTextProfile(String tittle, BuildContext context){
  final textTheme = Theme.of(context).textTheme;
  return Tab(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14.0),
      ),
      alignment: Alignment.center,
      child: Text(
        tittle,
        style: textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  );
}