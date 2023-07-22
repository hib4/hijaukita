import 'package:flutter/material.dart';


Widget tabText(String tittle, BuildContext context){
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
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}