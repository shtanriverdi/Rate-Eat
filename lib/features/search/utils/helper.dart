import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/emojione_monotone.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/tabler.dart';
import 'package:micro_yelp/core/core.dart';
import 'package:iconify_flutter/icons/map.dart' as iconify_map;

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class Helper {
  static SliderThemeData sliderTheme = SliderThemeData(
      valueIndicatorTextStyle: MicroYelpText.sliderLabel,
      valueIndicatorColor: MicroYelpColor.primaryColor,
      tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 0),
      rangeTickMarkShape:
          const RoundRangeSliderTickMarkShape(tickMarkRadius: 0),
      activeTrackColor: MicroYelpColor.primaryColor,
      inactiveTrackColor: MicroYelpColor.greyBorder,
      trackHeight: 2,
      thumbColor: MicroYelpColor.primaryColor,
      rangeThumbShape: const RoundRangeSliderThumbShape(
        disabledThumbRadius: 3,
        enabledThumbRadius: 8,
        pressedElevation: 3,
      ),
      thumbShape: const RoundSliderThumbShape(
        disabledThumbRadius: 3,
        enabledThumbRadius: 8,
        pressedElevation: 3,
      ));

  // Map for high-level and sub-categories
  static Map<String, List<String>> categoriesMap = {
    "Habesha": [
      "Breakfast",
      "Salad",
      "Wot",
      "Firfir",
      "Meat",
      "Combo",
    ],
    "Meat": [
      "Habeshan",
      "Chicken",
      "Beef",
      "Lamb",
      "Fish",
    ],
    "Fast Food": [
      "Sandwich",
      "Traditional",
      "Pasta",
      "Burger",
      "Pizza",
      "Salad",
      "Soup",
    ],
    "Drinks": [
      "Soft drinks",
      "Yoghurt",
      "Juice",
      "Shakes",
      "Hot beverages",
      "Mocktails",
      "Alcoholic drinks",
    ],
    "Desserts": [
      "Cake",
      "Pastry",
      "Ice cream",
      "Cookies",
      "Fruits",
    ],
    "Breakfast": [
      "Eggs",
      "Sandwich",
      "Pastry",
      "Traditional",
      "Fruits",
    ],
  };

  static final highLevelCategories = ["Breakfast", "Desserts", "Drinks", "Fast Food", "Habesha", "Meat"];

  static final disabledIcons = [
    const Iconify(Mdi.food_takeout_box, color: Colors.black45, size: 20),
    const Iconify(Fluent.leaf_three_16_regular,
        color: Colors.black45, size: 20),
    const Iconify(Ph.hamburger, color: Colors.black45, size: 20),
    const Iconify(Fluent.food_pizza_20_regular,
        color: Colors.black45, size: 20),
    const Iconify(Mdi.pasta, color: Colors.black45, size: 20),
    const Iconify(EmojioneMonotone.green_salad,
        color: Colors.black45, size: 20),
    const Iconify(Ep.dessert, color: Colors.black45, size: 20),
    const Iconify(Ic.outline_breakfast_dining, color: Colors.black45, size: 20),
    const Iconify(Tabler.soup, color: Colors.black45, size: 20),
    const Iconify(Fluent.drink_24_filled, color: Colors.black45, size: 20),
    const Iconify(iconify_map.Map.fish_cleaning,
        color: Colors.black45, size: 20),
  ];

  static final enabledIcons = [
    const Iconify(Mdi.food_takeout_box, color: Colors.white, size: 20),
    const Iconify(Fluent.leaf_three_16_regular, color: Colors.white, size: 20),
    const Iconify(Ph.hamburger, color: Colors.white, size: 20),
    const Iconify(Fluent.food_pizza_20_regular, color: Colors.white, size: 20),
    const Iconify(Mdi.pasta, color: Colors.white, size: 20),
    const Iconify(EmojioneMonotone.green_salad, color: Colors.white, size: 20),
    const Iconify(Ep.dessert, color: Colors.white, size: 20),
    const Iconify(Ic.outline_breakfast_dining, color: Colors.white, size: 20),
    const Iconify(Tabler.soup, color: Colors.white, size: 20),
    const Iconify(Fluent.drink_24_filled, color: Colors.white, size: 20),
    const Iconify(iconify_map.Map.fish_cleaning, color: Colors.white, size: 20),
  ];

  static String removeException(String error) {
    var ind = 0;
    for (var i = 0; i < error.length; i++) {
      if (error[i] == ":") {
        ind = i;
      }
    }
    error = error.substring(ind + 1);
    return error;
  }

  static String getMeridiem(int val) {
    if (0 <= val && val <= 719) {
      return "AM";
    }
    return "PM";
  }

  static String getMinutes(int val) {
    var min = (val % 60).toString();
    if (min.length == 1) {
      min = "0$min";
    }
    return min;
  }

  static String getHour(int val) {
    var time = "";
    if (0 <= val && val <= 59) {
      time = "12";
    } else if (60 <= val && val <= 779) {
      time = (val ~/ 60).toString();
    } else {
      time = ((val ~/ 60) - 12).toString();
    }

    if (time.length == 1) {
      time = "0$time";
    }
    return time;
  }

  static String getTimeFormat(int val) {
    String hour = getHour(val);
    String min = getMinutes(val);
    String merid = getMeridiem(val);
    return '$hour:$min $merid';
  }

  static int getIntegerFormat(String time) {
    String hour = time.substring(0, 2);
    String min = time.substring(3, 5);
    String merid = time.substring(6, 8);

    var intHour = int.parse(hour) * 60;
    var intMin = int.parse(min);

    if ((0 <= intHour && intHour <= 59) || (720 <= intHour && intHour <= 779)) {
      intHour = 0;
    }

    if (merid == "PM") {
      intHour += 720;
    }

    return intHour + intMin;
  }

  static getGlobalTime() {
    tz.initializeTimeZones();
    var ethZone = tz.getLocation('Europe/Istanbul');
    var now = tz.TZDateTime.now(ethZone);

    return now.toString();
  }

  static getTimeFromTimeZone(String now, int inc) {
    String time = now.substring(11, 16);
    var intHour = int.parse(time.substring(0, 2)) + inc;
    var intMin = time.substring(3, 5);

    var hourTemp = "";
    var min = intMin.length == 1 ? "0$intMin" : intMin;
    var merid = "";

    // SET MERID
    if (intHour == 0 || intHour < 12) {
      merid = "AM";
    } else {
      merid = "PM";
    }

    // SET Hour
    if (intHour == 0) {
      hourTemp = "12";
    } else if (intHour <= 12) {
      hourTemp = "$intHour";
    } else {
      hourTemp = "${intHour - 12}";
    }

    var hour = hourTemp.length == 1 ? "0$hourTemp" : hourTemp;

    return '$hour:$min $merid';
  }
}
