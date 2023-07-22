import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/tabler.dart';

final disabledIcons = [
  const Iconify(Mdi.food_takeout_box, color: Colors.black45, size: 30),
  const Iconify(Tabler.meat, color: Colors.black45, size: 30),
  const Iconify(Ph.hamburger, color: Colors.black45, size: 30),
  const Iconify(Fluent.drink_24_filled, color: Colors.black45, size: 30),
  const Iconify(Ic.outline_breakfast_dining, color: Colors.black45, size: 30),
  const Iconify(Ep.dessert, color: Colors.black45, size: 30),
];

final enabledIcons = [
  const Iconify(Mdi.food_takeout_box, color: Colors.white, size: 30),
  const Iconify(Tabler.meat, color: Colors.white, size: 30),
  const Iconify(Ph.hamburger, color: Colors.white, size: 30),
  const Iconify(Fluent.drink_24_filled, color: Colors.white, size: 30),
  const Iconify(Ic.outline_breakfast_dining, color: Colors.white, size: 30),
  const Iconify(Ep.dessert, color: Colors.white, size: 30),
];
