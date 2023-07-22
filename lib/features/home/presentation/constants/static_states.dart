import 'package:iconify_flutter/icons/tabler.dart';

import '../../data/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:micro_yelp/features/home/data/models/category_model.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:iconify_flutter/icons/mdi.dart';

/*
CATEGORY QUERIES

Fast Food
  Sandwich
  Traditional
  Pasta
  Burger
  Pizza
  Salad
  Soup

Meat
  Habeshan
  Chicken
  Beef
  Lamb
  Fish

Desserts
  Cake
  Pastry
  Ice cream
  Cookies
  Fruits

Breakfast
  Eggs
  Sandwich
  Pastry
  Traditional
  Fruits

Habesha Food
  Breakfast
  Salad
  Wot
  Firfir
  Meat
  Combo

Drinks
  Soft drinks
  Yoghurt
  Juice
  Shakes
  Hot beverages
  Mocktails
  Alcoholic drinks
*/

class HomePageStates {
  // High-level categories in valid order
  // "Habesha": 0
  // "Meat": 1
  // "Fast Food": 2
  // "Drinks": 3
  // "Breakfast": 4
  // "Desserts": 5

  // Map for high-level and sub-categories
  static Map<int, List<String>> categoriesMap = {
    // Except this "Habesha Food" in queries, rest is same!
    0: [
      "Breakfast",
      "Salad",
      "Wot",
      "Firfir",
      "Meat",
      "Combo",
    ],
    1: [
      "Habeshan",
      "Chicken",
      "Beef",
      "Lamb",
      "Fish",
    ],
    2: [
      "Sandwich",
      "Traditional",
      "Pasta",
      "Burger",
      "Pizza",
      "Salad",
      "Soup",
    ],
    3: [
      "Soft drinks",
      "Yoghurt",
      "Juice",
      "Shakes",
      "Hot beverages",
      "Mocktails",
      "Alcoholic drinks",
    ],
    4: [
      "Eggs",
      "Sandwich",
      "Pastry",
      "Traditional",
      "Fruits",
    ],
    5: [
      "Cake",
      "Pastry",
      "Ice cream",
      "Cookies",
      "Fruits",
    ],
  };

  // List of High-Level Category QUERIES
  static final List<String> listOfHighLevelCategoryParameters = [
    "Habesha Food",
    "Meat",
    "Fast Food",
    "Drinks",
    "Breakfast",
    "Desserts",
  ];

  // Global Key For Bottom Navigation Bar
  static GlobalKey globalKey = GlobalKey(debugLabel: 'bottom_bar');

  // Current selected section index: Affordable / Nearby / Top Rated
  static int selectedSectionIndex = 0;

  // For Backend Queries
  // Needed parameters for filtering and sorting queries
  static String selectedCategoryParameter = "";
  static String sortBy = "price";
  static String isFasting = "false";

  // Location for th user
  static String latitude = '';
  static String longitude = '';

  // Currently selected high level category status: { index, isActive }
  static int currentSelectedHighLevelCategoryIndex = -1;

  // Categories List
  static final categories = [
    Category(
        categoryName: "Habesha",
        categoryIcon: const Iconify(Mdi.food_takeout_box,
            color: Colors.black45, size: 30)),
    Category(
        categoryName: "Meat",
        categoryIcon:
            const Iconify(Tabler.meat, color: Colors.black45, size: 30)),
    Category(
      categoryName: "Fast Food",
      categoryIcon:
          const Iconify(Ph.hamburger, color: Colors.black45, size: 30),
    ),
    Category(
        categoryName: "Drinks",
        categoryIcon: const Iconify(Fluent.drink_24_filled,
            color: Colors.black45, size: 30)),
    Category(
        categoryName: "Breakfast",
        categoryIcon: const Iconify(Ic.outline_breakfast_dining,
            color: Colors.black45, size: 30)),
    Category(
        categoryName: "Desserts",
        categoryIcon:
            const Iconify(Ep.dessert, color: Colors.black45, size: 30)),
  ];

  // Set of selected Sub Category Indices for QUERIES
  static Set<int> selectedSubCategoryIndicesSet = {};

  // Sub categories for categories page
  static List<String> currentSubCategories = [];

  // Selected sections for Affordable/Nearby/Top Rated (item_list_selection widget)
  static List isSelected = [true, false, false];

// Reset every data
// static void resetHomePageState() {
//   selectedSectionIndex = 0;
//
//   selectedCategoryParameter = "";
//   sortBy = "price";
//
//   latitude = '';
//   longitude = '';
//
//   selectedCategories = {};
// }
}
