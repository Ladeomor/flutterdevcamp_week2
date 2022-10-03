import 'package:flutter/material.dart';

GestureDetector dropDown({name, onTapped}) {
  return GestureDetector(
      child: ListTile(title: Text(name)), onTap: () => onTapped());
}