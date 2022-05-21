import 'package:flutter/material.dart';
import 'package:fregies/models/product_model.dart';

//list map for strings key and value
List<Map<String, String>> splashData = [
  {
    'image': 'splash001.png',
    'title': 'Quick Delivery at your step',
    'caption':
        'Listen to podcast and open your world easily with the applications'
  },
  {
    'image': 'splash02.png',
    'title': 'Buy Groceries Easily With Us',
    'caption':
        'Listen to podcast and open your world easily with the applications'
  },
  {
    'image': 'splash03.png',
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

List<String> socials = [
  'assets/svg/twitter.svg',
  'assets/svg/google-icon.svg',
  'assets/svg/facebook-2.svg'
];

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

// List<DropdownMenuItem<String>> get country {
//   List<DropdownMenuItem<String>> menuItems = [
//     DropdownMenuItem(child: Text("USA"), value: "USA"),
//     DropdownMenuItem(child: Text("Canada"), value: "Canada"),
//     DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
//   ];
//   return menuItems;
// }

// String selectedCountry = 'USA';

//////////////////////////////////////////////////////////
// This is where the required data is starting from     //
//////////////////////////////////////////////////////////
String iconImage(iconImage) {
  if (iconImage == 'checkup') {
    return 'assets/icons/Artboard 13medIcons.png';
  } else if (iconImage == 'medication') {
    return 'assets/icons/Artboard 3medIcons.png';
  } else {
    return 'assets/icons/Artboard 5medIcons.png';
  }
}

List adverts = [
  "assets/icons/advert1.png",
  "assets/icons/advert2.png",
  "assets/icons/advert3.png"
];

List<ProductModel> productDB = [
  ProductModel(
      id: 1,
      product: "Orange",
      category: "Fruits",
      price: 4.6,
      discountPrice: 3.8,
      favourite: false,
      image: "assets/images/fruits/orange.png",
      rating: 4.3,
      quantity: 12,
      discription: "This is where the product description would be",
      unit: "\$",
      rate: "Kg",
      specialOffer: false),
  ProductModel(
      id: 2,
      product: "Brown Dates",
      category: "Dried",
      price: 3.2,
      discountPrice: 2.9,
      favourite: false,
      image: "assets/images/dried/brown-dates.png",
      rating: 4.0,
      quantity: 16,
      discription: "This is where the product description would be",
      unit: "\$",
      rate: "Kg",
      specialOffer: false),
  ProductModel(
      id: 3,
      product: "Cabbage",
      category: "Vegetable",
      price: 5.6,
      discountPrice: 4.7,
      favourite: false,
      image: "assets/images/veg/cabbage.png",
      rating: 4.1,
      quantity: 16,
      discription: "This is where the product description would be",
      unit: "\$",
      rate: "Kg",
      specialOffer: false),
  ProductModel(
      id: 4,
      product: "Others",
      category: "Cup Cake",
      price: 2.6,
      discountPrice: 1.5,
      favourite: false,
      image: "assets/images/others/cake.png",
      rating: 3.4,
      quantity: 11,
      discription: "This is where the product description would be",
      unit: "\$",
      rate: "Kg",
      specialOffer: false),
  ProductModel(
      id: 5,
      product: "Apple",
      category: "Fruits",
      price: 8.6,
      discountPrice: 7.2,
      favourite: false,
      image: "assets/images/fruits/apple.png",
      rating: 4.4,
      quantity: 22,
      discription: "This is where the product description would be",
      unit: "\$",
      rate: "Kg",
      specialOffer: false),
  ProductModel(
      id: 6,
      product: "Cashew",
      category: "Dried",
      price: 4.2,
      discountPrice: 3.9,
      favourite: false,
      image: "assets/images/dried/cashew.png",
      rating: 4.3,
      quantity: 20,
      discription: "This is where the product description would be",
      unit: "\$",
      rate: "Kg",
      specialOffer: false),
  ProductModel(
      id: 7,
      product: "Spinach",
      category: "Vegetable",
      price: 3.2,
      discountPrice: 2.8,
      favourite: false,
      image: "assets/images/veg/spinach.png",
      rating: 4.5,
      quantity: 20,
      discription: "This is where the product description would be",
      unit: "\$",
      rate: "Kg",
      specialOffer: false),
  ProductModel(
      id: 8,
      product: "Nutella",
      category: "Others",
      price: 2.6,
      discountPrice: 1.5,
      favourite: false,
      image: "assets/images/others/nutella.png",
      rating: 4.6,
      quantity: 20,
      discription: "This is where the product description would be",
      unit: "\$",
      rate: "Kg",
      specialOffer: false),
  ProductModel(
      id: 9,
      product: "Carrot",
      category: "Fruits",
      price: 5.6,
      discountPrice: 4.3,
      favourite: false,
      image: "assets/images/fruits/carrot.png",
      rating: 3.6,
      quantity: 22,
      discription: "This is where the product description would be",
      unit: "\$",
      rate: "Kg",
      specialOffer: false),
  ProductModel(
      id: 10,
      product: "Groundnut",
      category: "Dried",
      price: 14.2,
      discountPrice: 13.9,
      favourite: false,
      image: "assets/images/dried/grounut.png",
      rating: 4.2,
      quantity: 22,
      discription: "This is where the product description would be",
      unit: "\$",
      rate: "Kg",
      specialOffer: false),
  ProductModel(
      id: 11,
      product: "Spinach",
      category: "Vegetable",
      price: 4.6,
      discountPrice: 4.2,
      favourite: false,
      image: "assets/images/veg/garlic.png",
      rating: 4.1,
      quantity: 22,
      discription: "This is where the product description would be",
      unit: "\$",
      rate: "Kg",
      specialOffer: false),
  ProductModel(
      id: 12,
      product: "Milk",
      category: "Others",
      price: 2.6,
      discountPrice: 1.5,
      favourite: false,
      image: "assets/images/others/milk.png",
      rating: 3.0,
      quantity: 21,
      discription: "This is where the product description would be",
      unit: "\$",
      rate: "Kg",
      specialOffer: false),
  ProductModel(
      id: 13,
      product: "Respberry",
      category: "Fruits",
      price: 2.6,
      discountPrice: 1.5,
      favourite: false,
      image: "assets/images/fruits/berry.png",
      rating: 3.0,
      quantity: 5,
      discription:
          "Fresh Respberry for Vegan Smoothie. This is where the product description would be",
      unit: "\$",
      rate: "Kg",
      specialOffer: true),
  ProductModel(
      id: 14,
      product: "Tomatos",
      category: "Fruits",
      price: 2.6,
      discountPrice: 1.5,
      favourite: false,
      image: "assets/images/veg/tomato.png",
      rating: 3.0,
      quantity: 8,
      discription:
          "Fresh Respberry for Vegan Smoothie. This is where the product description would be",
      unit: "\$",
      rate: "Kg",
      specialOffer: true),
  ProductModel(
      id: 15,
      product: "Soyabeans",
      category: "Dried",
      price: 2.6,
      discountPrice: 1.5,
      favourite: false,
      image: "assets/images/dried/soybean.png",
      rating: 3.0,
      quantity: 4,
      discription:
          "Fresh Respberry for Vegan Smoothie. This is where the product description would be",
      unit: "\$",
      rate: "Kg",
      specialOffer: true),
  ProductModel(
      id: 16,
      product: "Honey",
      category: "Others",
      price: 2.6,
      discountPrice: 1.5,
      favourite: false,
      image: "assets/images/others/honey.png",
      rating: 3.0,
      quantity: 4,
      discription:
          "Natural Honey with no sugar. This is where the product description would be",
      unit: "\$",
      rate: "Kg",
      specialOffer: true),
];

List<Map<String, dynamic>> specialOffer = [
  {
    "title": "Fresh Respberry for Vegan Smoothie",
    "weight-price": {"price": "\$43.0", "measure": "200g"},
    "delivery-date": "Tuesday",
    "qty": 5,
    "image": "assets/images/fruits/berry.png"
  },
  {
    "title": "Fresh harvested Tomatos for pastery",
    "weight-price": {"price": "\$20.0", "measure": "180g"},
    "delivery-date": "Tuesday",
    "qty": 8,
    "image": "assets/images/veg/tomato.png"
  },
  {
    "title": "Well dried soybeans for home made drinks",
    "weight-price": {"price": "\$4.2", "measure": "10cups"},
    "delivery-date": "Tuesday",
    "qty": 4,
    "image": "assets/images/dried/soybean.png"
  },
  {
    "title": "Natural Honey with no sugar",
    "weight-price": {"price": "\$4.2", "measure": "200g"},
    "delivery-date": "Tuesday",
    "qty": 6,
    "image": "assets/images/others/pngwing.com (18).png"
  },
];

List<Widget> tabList = const [
  Tab(text: "All"),
  Tab(text: "Fruits"),
  Tab(text: "Vegetables"),
  Tab(text: "Dried"),
  Tab(text: "Others"),
];

List paymentMethodList = [
  {"icon": "assets/icons/card-dark.png", "caption": "Credit/Debit/Card"},
  {"icon": "assets/icons/globe.png", "caption": "Net Banking"},
  {"icon": "assets/icons/money.png", "caption": "Cash on Delivery"},
];

List<ProductModel> favouriteList = [];
