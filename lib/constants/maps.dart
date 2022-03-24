import 'package:flutter/material.dart';

//list map for strings key and value
List<Map<String, String>> splashData = [
  {
    'image': 'splash1.png',
    'title': 'Quick Delivery at your step',
    'caption':
        'Listen to podcast and open your world easily with the applications'
  },
  {
    'image': 'splash2.png',
    'title': 'Buy Groceries Easily With Us',
    'caption':
        'Listen to podcast and open your world easily with the applications'
  },
  {
    'image': 'splash3.png',
    'title': 'Choose from our best menu',
    'caption':
        'Listen to podcast and open your world easily with the applications'
  },
];

//List map for string and dynamics

List<Map<String, dynamic>> supportDetails = [
  {
    'main': 'Terms & Condition',
    'sub': 'Read our T&C',
    'icon': Icons.receipt_long_outlined
  },
  {'main': 'About Us', 'sub': 'Change your password', 'icon': Icons.info},
  {'main': 'Rate Us', 'sub': 'update your account', 'icon': Icons.star},
  {'main': 'App Version', 'sub': 'Sign out of account', 'icon': Icons.apps},
];

List<String> doctors = ['team1.jpg', 'team2.jpg', 'team3.jpg'];

List<Color> socialColor = [
  Colors.lightBlueAccent,
  Colors.red,
  Colors.blue,
];

List<String> gender = ["Male", "Female"];

//List for only dynamics
final List<dynamic> profileSub = [
  "12 July, 1992",
  09034738274,
  'glorimat@gmail.com',
  '12 Marian Road Cal.',
  'Insp. Frank Edet',
  '08034543245',
];

//drop down list

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(
      child: Text('Check Up'),
      value: 'checkup',
    ),
    const DropdownMenuItem(
      child: Text('Medication'),
      value: 'medication',
    ),
    const DropdownMenuItem(
      child: Text('Product'),
      value: 'product',
    ),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get country {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("USA"), value: "USA"),
    DropdownMenuItem(child: Text("Canada"), value: "Canada"),
    DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
  ];
  return menuItems;
}

String selectedCountry = 'USA';

String iconImage(iconImage) {
  if (iconImage == 'checkup') {
    return 'assets/icons/Artboard 13medIcons.png';
  } else if (iconImage == 'medication') {
    return 'assets/icons/Artboard 3medIcons.png';
  } else {
    return 'assets/icons/Artboard 5medIcons.png';
  }
}
